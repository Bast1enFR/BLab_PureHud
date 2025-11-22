window.addEventListener('message', function(event) {
    const data = event.data;
    if (data.action === "update") {
        document.querySelector('#health .fill').style.width = data.health + '%';
        document.querySelector('#armor .fill').style.width = data.armor + '%';
        document.querySelector('#stamina .fill').style.width = data.stamina + '%';
        document.getElementById('hud').style.opacity = '1';
    }
    if (data.action === "hide") {
        document.getElementById('hud').style.opacity = '0';
    }
});