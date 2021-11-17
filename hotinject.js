// lazy way of implementing hot reloading
const socket = new WebSocket('ws://localhost:8081');

socket.addEventListener('message', function (event) {
    if (event.data=="reload"){
        location.reload();
    }
});