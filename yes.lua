local module = {}

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local char = plr.Character

plr.PlayerGui.ClassGui.Main.Disabled = true 

for _, v in pairs(plr.PlayerGui.ClassGui.MainHUD.Abilites:GetChildren()) do 
    v.CooldownDisplay.Text = ''
    v.Icon.ImageTransparency = 0
end 

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


local canatk = true 
local canab1 = true 
local canab2 = true 
local cancrit = true 

local atktimer = 0 
local ab1timer = 0 
local ab2timer = 0 
local crittimer = 0 

local function roundDecimals(num, places)
    places = math.pow(10, places or 0)
    num = num * places

    if num >= 0 then
        num = math.floor(num + 0.5)
    else
        num = math.ceil(num - 0.5)
    end

    return num / places
end



local function cooling(timer, move)
    spawn(function()
        local gui = game.Players.LocalPlayer.PlayerGui.ClassGui.MainHUD.Abilites
        
            local truegui 
    
        move = string.lower(move)
        
        if move == 'atk' then 
            if atktimer > 0 then 
                atktimer = timer 
                return 
            end
            atktimer = timer 
            truegui = gui.Attack
            canatk = false
            
            truegui.Icon.ImageTransparency = .5
            repeat 
                task.wait(.1)
                truegui.CooldownDisplay.Text = roundDecimals(atktimer, 1)
                atktimer = atktimer - .1
            until atktimer <= 0 
            truegui.CooldownDisplay.Text = ""
            canatk = true
            atktimer = 0 
            truegui.Icon.ImageTransparency = 0 
            
        elseif move == 'ab1' then 
            if ab1timer > 0 then 
                ab1timer = timer 
                return 
            end
            ab1timer = timer 
            canab1 = false
            truegui = gui.Ability1
            
            truegui.Icon.ImageTransparency = .5
            repeat 
                task.wait(.1)
                truegui.CooldownDisplay.Text = roundDecimals(ab1timer, 1)
                ab1timer = ab1timer - .1
            until ab1timer <= 0 
            truegui.CooldownDisplay.Text = ""
            canab1 = true
            ab1timer = 0 
            truegui.Icon.ImageTransparency = 0 
            
        elseif move == 'ab2' then 
            if ab2timer > 0 then 
                ab2timer = timer 
                return 
            end
            ab2timer = timer 
            canab2 = false 
            truegui = gui.Ability2
            
            truegui.Icon.ImageTransparency = .5
            repeat 
                task.wait(.1)
                truegui.CooldownDisplay.Text = roundDecimals(ab2timer, 1)
                ab2timer = ab2timer - .1
            until ab2timer <= 0 
            truegui.CooldownDisplay.Text = ""
            canab2 = true
            ab2timer = 0 
            truegui.Icon.ImageTransparency = 0 
            
        elseif move == 'crit' then
            if crittimer > 0 then 
                crittimer = timer 
                return 
            end
            crittimer = timer 
            cancrit = false 
            truegui = gui.Critical 
            
            truegui.Icon.ImageTransparency = .5
            repeat 
                task.wait(.1)
                truegui.CooldownDisplay.Text = roundDecimals(crittimer, 1)
                crittimer = crittimer - .1
            until crittimer <= 0 
            truegui.CooldownDisplay.Text = ""
            cancrit = true
            crittimer = 0 
            truegui.Icon.ImageTransparency = 0 
        end
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

module.CreateProjectile = function(projpath, cf, tobe, dam, col)
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
            v43.Damage.Value = dam or v43.Damage.Value
            local t = v43.Transparency
            for _, v in pairs(v43:GetChildren()) do
                if v.Name == "ProjectileHandler" then
                    local l__ProjectileHandler__44 = v
                    v.Projectile.Value = v43
                    v.Parent = l__Character__4
                    if v43.Name == "ability2b" then
                        v.Disabled = true
                    end
                end
            end
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
                        until v43.Parent == nil or t ~= v43.Transparency
                        tobe(oldcf)
                    end
                end
            )
        end
    )
end

module.EffectApply = function(effect, togo)
    local c = plrs:GetPlayerFromCharacter(togo.Parent)
    if togo.Name ~= 'Head' or not c then 
        return
    end 
    
    if effect:IsA('BillboardGui') and effect.Parent.Parent.Parent == game.ReplicatedStorage.Classes then 
        ok(effect, togo, togo.Parent)
    end
end

module.Hologram = function()
    local yescreateproj = module.CreateProjectile
    yescreateproj(game.ReplicatedStorage.Classes.DANCER.Projectile.head, char.Head.CFrame)
    yescreateproj(game.ReplicatedStorage.Classes.DANCER.Projectile.limb, char['Right Arm'].CFrame)
    yescreateproj(game.ReplicatedStorage.Classes.DANCER.Projectile.limb, char['Left Arm'].CFrame)
    yescreateproj(game.ReplicatedStorage.Classes.DANCER.Projectile.limb, char['Right Leg'].CFrame)
    yescreateproj(game.ReplicatedStorage.Classes.DANCER.Projectile.limb, char['Left Leg'].CFrame)
    yescreateproj(game.ReplicatedStorage.Classes.DANCER.Projectile.torso, char['Torso'].CFrame)
end

module.Dash = function(poww, mode)
    spawn(
        function()
            local l__Character__4 = game.Players.LocalPlayer.Character
            local v40 = Instance.new("BodyVelocity")
            v40.MaxForce = Vector3.new(99999999, 0, 99999999)
            if mode == 'Foward' then
                v40.Velocity = l__Character__4.HumanoidRootPart.CFrame.lookVector * Vector3.new(poww, 0, poww)
            elseif mode == 'MovementDirection' then
                v40.Velocity = l__Character__4.Humanoid.MoveDirection * Vector3.new(poww, 0, poww)
            end
            if l__Character__4.Humanoid.MoveDirection.magnitude == 0 then
                v40.Velocity = l__Character__4.HumanoidRootPart.CFrame.lookVector * Vector3.new(poww, 0, poww)
            end
            v40.Parent = l__Character__4.HumanoidRootPart
            task.wait(0.2)
            v40:Destroy()
        end
    )
end

module.CustomSkin = function(armorpieces)
    local class = game.ReplicatedStorage.Classes[plr.Character.CurrentClass.Value]
    local function adjustskin()
        for i, v in pairs(armorpieces) do
            if type(v) == "string" then
                ok(game.ReplicatedStorage.Classes[string.upper(v)].MainSkin[i], location)
            else
                ok(v, location)
            end
        end
        
        for _, v in pairs(class.MainSkin:GetChildren()) do
            if not location:FindFirstChild(v.Name) then
                ok(v, location)
            end
        end
        
    end

    if not class:FindFirstChild("Part") then
        ok(game.ReplicatedStorage.Part, class)
        local n = class:WaitForChild("Part")
        adjustskin(n)
        task.wait(3)
    end

    chooseskin("Part")

    task.wait(1)
end

module.UsingAttack = {}
module.UsingAbility1 = {}
module.UsingAbility2 = {}
module.UsingCritical = {}

function module.UsingAttack:Connect(func, cd)
    if canatk and char.Stats.Disable.Value == 0 then 
        return cooling(cd, 'atk')
    end 
    
    
    func()
end

function module.UsingAbility1:Connect(func, cd)
    if canab1 and char.Stats.Disable.Value == 0 then 
        return cooling(cd, 'ab1')
    end 
    
    
    func()
end

function module.UsingAbility2:Connect(func, cd)
    if canab2 and char.Stats.Disable.Value == 0 then 
        return cooling(cd, 'ab2')
    end 
    
    
    func()
end

function module.UsingCritical:Connect(func, cd)
    if cancrit and char.Stats.Disable.Value == 0 then 
        return cooling(cd, 'crit')
    end 
    
    
    func()
end

if char:FindFirstChild'run' then 
    return error'nah'
end

local c = Instance.new('BoolValue', char)
c.Name = 'run'



return module
