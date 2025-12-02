import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// For V1 API - Simplified version using HTTP v1 endpoint
// You'll need to get a service account and generate an access token
// OR use a pre-generated access token stored as a secret

const FIREBASE_ACCESS_TOKEN = Deno.env.get('FIREBASE_ACCESS_TOKEN')!
const PROJECT_ID = Deno.env.get('FIREBASE_PROJECT_ID')!

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

    // Build FCM V1 message
    const message = {
      message: {
        token: token,
        notification: {
          title: title,
          body: body,
        },
        data: data ? Object.fromEntries(
          Object.entries(data).map(([k, v]) => [k, String(v)])
        ) : {},
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
          'Authorization': `Bearer ${FIREBASE_ACCESS_TOKEN}`,
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

