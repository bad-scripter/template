local module = {}

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local char = plr.Character

if game.Players.LocalPlayer:FindFirstChild("remotesFired") == nil then
	local v7 = Instance.new("IntValue", game.Players.LocalPlayer);
	v7.Value = 0;
	v7.Name = "remotesFired";
else
	v7 = game.Players.LocalPlayer:FindFirstChild("remotesFired");
end;
function pass()
	local v8 = v7.Value + 1;
	v7.Value = v8;
	return "{CS-G10-" .. math.floor((v8 * 7) ^ 2.7) + 25 .. "-AB2g-dAB50NYU}";
end;
function ok(part, pathh, ye)
    pcall(function()
        spawn(function()
            local args = {
                [1] = pass(),
                [2] = ye or game.Workspace.NormalDummy2,
                [3] = part,
                [4] = pathh
            }
        
            game:GetService("ReplicatedStorage").Remotes.EffectApply:InvokeServer(unpack(args))
        end)
    end)
end

module.GetClosest = function()
    local LocalPlayer = plr
    local Character = char
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not (Character or HumanoidRootPart) then
        return
    end

    local TargetDistance = math.huge
    local team
    if workspace[LocalPlayer.Name]:FindFirstChild("Red") then
        team = "Red"
    elseif workspace[LocalPlayer.Name]:FindFirstChild("Blue") then
        team = "Blue"
    end
    if team == nil then
        for i, v in ipairs(workspace:GetChildren()) do
            local stats = v:FindFirstChild("Stats")
            if stats then
                local hp = stats:FindFirstChild("CurrentHP")
                if hp.Value > 0 then
                    if
                        v ~= Character and v:FindFirstChild("HumanoidRootPart") and not v.Name:find("ability") and
                            v:FindFirstChild("Playing") or
                            v.Name:find("Dummy") and not v:FindFirstChild("Playing")
                     then
                        local TargetHRP = v:FindFirstChild("HumanoidRootPart")
                        if TargetHRP and HumanoidRootPart then
                            local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                            if mag < TargetDistance then
                                TargetDistance = mag
                                Target = v
                            end
                        end
                    end
                end
            end
        end
    else
        for i, v in ipairs(workspace:GetChildren()) do
            local stats = v:FindFirstChild("Stats")
            if stats then
                local hp = stats:FindFirstChild("CurrentHP")
                if hp.Value > 0 then
                    if
                        v ~= Character and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Playing") and
                            not v:FindFirstChild(team) or
                            v.Name:find("Dummy")
                     then
                        local TargetHRP = v:FindFirstChild("HumanoidRootPart")
                        if TargetHRP and HumanoidRootPart then
                            local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                            if mag < TargetDistance then
                                TargetDistance = mag
                                Target = v
                            end
                        end
                    end
                end
            end
        end
    end
    return Target.HumanoidRootPart
end

module.CreateProjectile = function()
    spawn(
        function()
            local l__Remotes__13 = game.ReplicatedStorage.Remotes
            local l__LocalPlayer__2 = game.Players.LocalPlayer
            local l__Character__4 = l__LocalPlayer__2.Character
            local l__ability2b__41 = projpath
            local v42 = cf
            local v43 = l__ability2b__41:Clone()
            v43.Owner.Value = l__LocalPlayer__2
            v43.Origin.Value = v42.p
            v43.CFrame = v42
            v43.Color = col or l__LocalPlayer__2.CharacterColors.WeaponColor.Value
            v43.Speed.Value = v43.Speed.Value
            if v43:FindFirstChild "Damage" then
                v43.Damage.Value = dam or v43.Damage.Value
            end
            local t = v43.Transparency
            if v43.Name == "ability2b" then
                chosen = v43
            end
            v43.Parent = workspace
            l__Remotes__13.Projectile:FireServer(
                l__ability2b__41,
                v42,
                col or l__LocalPlayer__2.CharacterColors.WeaponColor.Value
            )
            spawn(
                function()
                    if tobe then
                        local oldcf = v43.CFrame
                        local oldpos
                        task.wait()
                        repeat
                            oldcf = v43.CFrame
                            task.wait()
                        until v43.Parent == nil
                        tobe(oldcf)
                    end
                end
            )
        end
    )
end

module.EffectApply = function(effect, togo)
    if togo.Name ~= 'Head' or plrs:GetPlayerFromCharacter(togo.Parent) then 
        return 
    end 
    
    if effect:IsA('BillboardGui') and effect:FIndFirstAncestor(game.ReplicatedStorage.Classes) then 
        ok(effect, togo, togo.Parent)
    end
end



return module
