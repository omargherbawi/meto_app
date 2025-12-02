import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// For V1 API, we need the service account JSON
const SERVICE_ACCOUNT_JSON = Deno.env.get('FIREBASE_SERVICE_ACCOUNT')!
const PROJECT_ID = Deno.env.get('FIREBASE_PROJECT_ID')!

// Get OAuth2 access token
async function getAccessToken(): Promise<string> {
  const serviceAccount = JSON.parse(SERVICE_ACCOUNT_JSON)
  
  const jwt = await createJWT(serviceAccount)
  
  const response = await fetch('https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      assertion: jwt,
    }),
  })
  
  const data = await response.json()
  return data.access_token
}

// Create JWT for OAuth2
async function createJWT(serviceAccount: any): Promise<string> {
  const header = {
    alg: 'RS256',
    typ: 'JWT',
  }
  
  const now = Math.floor(Date.now() / 1000)
  const payload = {
    iss: serviceAccount.client_email,
    scope: 'https://www.googleapis.com/auth/firebase.messaging',
    aud: 'https://oauth2.googleapis.com/token',
    exp: now + 3600,
    iat: now,
  }
  
  // Note: In production, you'd need to sign this with the private key
  // For Deno, you might need to use a library or handle this differently
  // This is a simplified version - you may need to adjust based on your setup
  
  const base64Header = btoa(JSON.stringify(header))
  const base64Payload = btoa(JSON.stringify(payload))
  const unsignedToken = `${base64Header}.${base64Payload}`
  
  // You'll need to sign this with the private key from service account
  // For now, this is a placeholder - you may need to use a JWT library
  return unsignedToken
}

Deno.serve(async (req: Request) => {
  try {
    const { token, title, body, data } = await req.json()

    if (!token || !title || !body) {
      return new Response(
        JSON.stringify({ error: 'Missing required fields: token, title, body' }),
        { 
          headers: { 'Content-Type': 'application/json' },
          status: 400 
        }
      )
    }

    // Get access token
    const accessToken = await getAccessToken()

    // Build FCM V1 message
    const message = {
      message: {
        token: token,
        notification: {
          title: title,
          body: body,
        },
        data: data || {},
        android: {
          priority: 'high',
        },
        apns: {
          headers: {
            'apns-priority': '10',
          },
          payload: {
            aps: {
              sound: 'default',
            },
          },
        },
      },
    }

    const response = await fetch(
      `https://fcm.googleapis.com/v1/projects/${PROJECT_ID}/messages:send`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${accessToken}`,
        },
        body: JSON.stringify(message),
      }
    )

    const result = await response.json()
    
    return new Response(JSON.stringify(result), {
      headers: { 'Content-Type': 'application/json' },
      status: response.ok ? 200 : 500,
    })
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { 
        headers: { 'Content-Type': 'application/json' },
        status: 500 
      }
    )
  }
})

