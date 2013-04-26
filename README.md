reflector (NOTE: spec below is not yet implemented)
=========

A simple pub/sub server for inter-app communication. Built with games and
second-screen applications in mind.

## Requirements
- Use traditional HTTP connections and verbs (no fancy websockets or
  long-polling tricks).
- Keep server interaction overhead minimal; applications should build messaging
  on top of the server.
- Aim to keep message delivery times under three seconds.

## Reasoning

### Traditional HTTP

There are lots of pub/sub systems and services built for low latency using
modern browser features. Faye, Slanger, Pusher, Pubnub, Socket.io, SignalR, and
others make heavy demands of their clients. By using traditional HTTP requests,
clients need only support a minimum feature set to make use of the server.

### Minimal communication overhead

Clients should use the server as a pipeline. Handshaking and communication
overhead should be minimal.

### Delivery times under three seconds

HTTP requests are short-lived so clients need to poll the server to check for
new messages. With that in mind, applications should be designed with high
latency in mind. I'd like the crossroads between server performance and user
expectations to be under three seconds in the worst case, not accounting for
network infrastructure problems like 3G dropout.

## Model

Reflector has three basic units: rooms, channels, and messages.

### Rooms

A room is a messaging hub. The client who provisions a room may have extended
control over the room in the future.

### Channels

Channels are transports for messages, connecting clients to rooms. Clients can
send messages on a channel or poll for newly-arrived messages. Each client gets
a unique channel upon connection to a room.

### Messages

Messages are UTF-8 strings encapsulated in a JSON data structure. See the
examples below.

Messages are short-lived. By default, they expire after a minute. This is
configured in [config/initializers/message_lifetime.rb](config/initializers/message_lifetime.rb).

## Example dialogue

```bash
# Create a room
client1 POST /rooms
=> { room: { key: 'room-key' }, channel: { key: 'client1-chan-key' } }

# Send a message to the room
client1 POST /channels/client1-chan-key { message: { body: 'server says hi' } }

# Connect a second client to the room
client2 POST /channels { room: { key: 'room-key' } }
=> { channel: { key: 'client2-chan-key' } }

# Client 2 checks for messages
client2 GET /channels/client2-chan-key
=> { messages: [ { id: 5, body: 'server says hi' } ] }

# Client 1 sends a message, client 2's message list is updated
client1 POST /channels/client1-chan-key { message: { body: 'I live!' } }
client2 GET /channels/client2-chan-key
=> { messages: [ { id: 5, body: 'server says hi' }, { id: 6, body: 'I live!' } ] }

# Client 2 checks for new messages in the timeline
client2 GET /channels/client2-chan-key/since/5
=> { messages: [ { id: 6, body: 'I live!' } ] }

# Client 2 sends a message to the room, client 1 sees it
client2 POST /channels/client2-chan-key { message: { body: 'Simpleton.' } }
client1 GET /channels/client1-chan-key
=> { messages: [ { id: 7, body: 'Simpleton.' } ] }
```
