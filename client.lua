local showHud = true

-- Toggle F11 propre
RegisterKeyMapping('togglehud', 'Activer/Désactiver BLab HUD', 'keyboard', 'F11')

RegisterCommand('togglehud', function()
    showHud = not showHud
    if not showHud then
        SendNUIMessage({ action = "hide" })
    end
    exports.Blab_Notify:Notify("BLab", "Notification terminée, on est des tueurs ! Notification terminée, on est des tueurs ! Notification terminée, on est des tueurs !", "success", 6000)
end)

-- Thread principal HUD
CreateThread(function()
    while true do
        local waitTime = 500
        if showHud and not IsPauseMenuActive() and not IsPedDeadOrDying(PlayerPedId()) then
            waitTime = 100
            local ped = PlayerPedId()
            local health = math.max(0, (GetEntityHealth(ped) - 100)) / 100 * 100
            local armor = GetPedArmour(ped)
            local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())

            SendNUIMessage({
                action = "update",
                health = health,
                armor = armor,
                stamina = stamina
            })
        else
            waitTime = 500
            SendNUIMessage({ action = "hide" })
        end

        Wait(waitTime)
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3) -- 3 = cache vie + armure
        EndScaleformMovieMethod()
    end
end)
