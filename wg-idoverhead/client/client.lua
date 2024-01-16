--__        __   ____       ____    _____  __     __
--\ \      / /  / ___|     |  _ \  | ____| \ \   / /
-- \ \ /\ / /  | |  _      | | | | |  _|    \ \ / / 
--  \ V  V /   | |_| |     | |_| | | |___    \ V /  
--   \_/\_/     \____|     |____/  |_____|    \_/   


local Config = {} -- This defines the config table
Config.ToggleKey = 303 -- This toggle key is set to U

local showServerId = false

RegisterKeyMapping('toggleServerId', 'Toggle Server ID Display', 'keyboard', 'U')

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustReleased(0, Config.ToggleKey) then -- This is U key
            showServerId = not showServerId
        end

        if showServerId then
            for _, player in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(-1)
                local pedCoords = GetEntityCoords(ped)

                local serverId = GetPlayerServerId(player)

                local x, y, z = table.unpack(pedCoords)
                z = z + 1.0  -- The height to display the text above head

                DrawText3D(x, y, z, '~h~SERVER ID: ' .. serverId)
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        SetTextScale(1.0, 1.0)  -- Text scale and size
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(0, 0, 255, 255)  -- Colour of text set to blue
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()

        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local width = EndTextCommandGetWidth(0)
        local height = 0.02  -- Height of text

        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x - width / 2, _y - height / 2)
    end
end

