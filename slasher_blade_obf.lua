local m = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/";
local h = (loadstring(game:HttpGet(m .. "Library.lua")))();
local w = (loadstring(game:HttpGet(m .. "addons/ThemeManager.lua")))();
local Z = (loadstring(game:HttpGet(m .. "addons/SaveManager.lua")))();
local U = h.Options;
local V = h.Toggles;
local q = h:CreateWindow({
		Title = "Slim Hub",
		Footer = "feito por chad",
		NotifySide = "Right",
		ShowCustomCursor = true,
		Resizable = true,
		Size = UDim2.fromOffset(650, 500),
		Center = true,
		AutoShow = true,
	});
local P = { AutoFarm = q:AddTab("Auto Farm"), Auto = q:AddTab("Auto"), ["UI Settings"] = q:AddTab("UI Settings") };
local E = game:GetService("ReplicatedStorage");
local u = game:GetService("Players");
local X = u.LocalPlayer;
local d = (((E:WaitForChild("Remote")):WaitForChild("Event")):WaitForChild("Combat")):WaitForChild("M1");
local r = (workspace:WaitForChild("Live")):WaitForChild("MobModel");
local S = (((E:WaitForChild("Remote")):WaitForChild("Event")):WaitForChild("Upgrade")):WaitForChild("[C-S]TryAddPoint");
local p = (((E:WaitForChild("Remote")):WaitForChild("Function")):WaitForChild("Upgrade")):WaitForChild("[C-S]GetUpgradeData");
local R = (workspace:WaitForChild("Live")):WaitForChild("DropItem");
local T = (((E:WaitForChild("Remote")):WaitForChild("Event")):WaitForChild("SkillTree")):WaitForChild("[C-S]TryReleaseSkill");
local W = (((E:WaitForChild("Remote")):WaitForChild("Event")):WaitForChild("Skill")):WaitForChild("[C-S]SkillDamage");
local H = (((E:WaitForChild("Remote")):WaitForChild("Function")):WaitForChild("Luck")):WaitForChild("[C-S]DoLuck");
local Y = (((E:WaitForChild("Remote")):WaitForChild("Function")):WaitForChild("SkillTree")):WaitForChild("[C-S]GetSkillData");
local g = require((E:WaitForChild("Config")):WaitForChild("SkillHelper"));
local function L(m)
	local h = X.Character;
	if not h or not h:FindFirstChild("HumanoidRootPart") then
		return {};
	end;
	local w = h.HumanoidRootPart;
	local Z = w.Position;
	local U = {};
	for h, w in r:GetChildren() do
		if w:GetAttribute("Dead") then
			continue;
		end;
		if not w.PrimaryPart then
			continue;
		end;
		local V = w.PrimaryPart.Position;
		local q = Vector3.new(Z.X, 0, Z.Z);
		local P = Vector3.new(V.X, 0, V.Z);
		if ((q - P)).Magnitude <= m then
			table.insert(U, w.Name);
		end;
	end;
	return U;
end;
local function i()
	local m = {};
	local h = {};
	for w, Z in r:GetChildren() do
		if Z:GetAttribute("Dead") then
			continue;
		end;
		if not Z:FindFirstChild("Humanoid") then
			continue;
		end;
		local U = Z.Humanoid.DisplayName;
		if U and not h[U] then
			h[U] = true;
			table.insert(m, U);
		end;
	end;
	table.sort(m);
	return m;
end;
local function z(m)
	for h, w in r:GetChildren() do
		if w:GetAttribute("Dead") then
			continue;
		end;
		if not w:FindFirstChild("Humanoid") then
			continue;
		end;
		if not w.PrimaryPart then
			continue;
		end;
		if w.Humanoid.DisplayName == m then
			return w;
		end;
	end;
	return nil;
end;
local function N(m, h, w)
	local Z = m.PrimaryPart;
	if not Z then
		return nil;
	end;
	local U = Z.Position;
	local V = Z.CFrame;
	if h == "Front" then
		return (U + V.LookVector * w) + Vector3.new(0, 0, 0);
	elseif h == "Behind" then
		return (U - V.LookVector * w) + Vector3.new(0, 0, 0);
	elseif h == "On Top" then
		return U + Vector3.new(0, w, 0);
	elseif h == "Left" then
		return (U - V.RightVector * w) + Vector3.new(0, 0, 0);
	elseif h == "Right" then
		return (U + V.RightVector * w) + Vector3.new(0, 0, 0);
	end;
	return U;
end;
local function o(m)
	local h = X.Character;
	if not h or not h:FindFirstChild("HumanoidRootPart") then
		return;
	end;
	local w = h.HumanoidRootPart;
	w.CFrame = CFrame.new(m);
end;
local b = false;
local A = nil;
local G = 0;
local y = false;
local t = false;
local a = 0;
local l = false;
local I = 0;
local j = game:GetService("VirtualInputManager");
local c = false;
local O = 0;
local K = false;
local f = 0;
local Q = 0;
local k = nil;
local B = { SetText = function()
 
		end };
local x = nil;
local F = 0;
local function e()
	local m = {};
	local h, w = pcall(function()
			return Y:InvokeServer();
		end);
	if h and (w and type(w) == "table") then
		local h = w.use;
		if h and type(h) == "table" then
			for w = 1, 3, 1 do
				local Z = h[w];
				if Z and (type(Z) == "string" and Z ~= "") then
					table.insert(m, Z);
				end;
			end;
		end;
	end;
	if #m == 0 then
		local h, w = pcall(function()
				return X:FindFirstChild("Setting");
			end);
		if h and w then
			local h = w:FindFirstChild("Use");
			if h then
				for h, w in h:GetChildren() do
					pcall(function()
						local h = w:IsA("ObjectValue") and w.Value or w.Name;
						if type(h) == "string" and h ~= "" then
							table.insert(m, h);
						end;
					end);
				end;
			end;
		end;
	end;
	return m;
end;
local function n(m)
	local h, w = pcall(function()
			local h = workspace:GetAttribute("Tick") or tick();
			local w = X:GetAttribute(m);
			if not w then
				return false;
			end;
			local Z = g.getCooldown(m);
			if not Z then
				return false;
			end;
			return (h - w) < Z;
		end);
	if h then
		return w;
	end;
	return false;
end;
local D = false;
local function v()
	local m = {};
	for h, w in r:GetChildren() do
		if not w:GetAttribute("Dead") and (w.Name and w.Name ~= "") then
			table.insert(m, w.Name);
		end;
	end;
	return m;
end;
task.spawn(function()
	pcall(function()
		if W then
			local m;
			m = hookfunction(W.FireServer, function(h, ...)
					local w = { ... };
					if V and (V.AllMobsHit and V.AllMobsHit.Value) then
						if #w >= 2 and type(w[2]) == "table" then
							local Z = v();
							if #Z > 0 then
								w[2] = Z;
								return m(h, unpack(w));
							end;
						end;
					end;
					return m(h, ...);
				end);
			D = true;
		end;
	end);
end);
local s = P.AutoFarm:AddLeftGroupbox("Kill Aura");
s:AddToggle("KillAuraToggle", {
	Text = "Kill Aura",
	Default = false,
	Tooltip = "Ataca automaticamente mobs pr\195\179ximos",
	Callback = function(m)
		b = m;
		if not m then
			if A then
				A:Disconnect();
				A = nil;
			end;
		end;
	end,
});
s:AddSlider("AttackDelay", {
	Text = "Attack Delay",
	Default = 200,
	Min = 50,
	Max = 2000,
	Rounding = 0,
	Suffix = " ms",
	Tooltip = "Intervalo entre ataques em milissegundos",
});
s:AddSlider("AttackRange", {
	Text = "Range",
	Default = 8,
	Min = 4,
	Max = 20,
	Rounding = 0,
	Suffix = " studs",
	Tooltip = "Raio para detectar mobs",
});
s:AddDivider();
local J = s:AddLabel({ Text = "Status: Desligado", DoesWrap = false, Size = 14 });
V.KillAuraToggle:OnChanged(function()
	if V.KillAuraToggle.Value then
		J:SetText("Status: Ligado - Atacando...");
		h:Notify({ Title = "Kill Aura", Description = "Ativado!", Time = 2 });
	else
		J:SetText("Status: Desligado");
		h:Notify({ Title = "Kill Aura", Description = "Desativado!", Time = 2 });
	end;
end);
local C = P.AutoFarm:AddLeftGroupbox("Auto Teleport");
local function M()
	local m = i();
	U.SelectedMob:SetValues(m);
	if #m > 0 and not U.SelectedMob.Value then
		U.SelectedMob:SetValue(m[1]);
	end;
end;
C:AddDropdown("SelectedMob", {
	Text = "Select Mob",
	Values = {},
	Default = nil,
	AllowNull = true,
	Tooltip = "Selecione o mob para teleportar",
});
C:AddButton({ Text = "Refresh Mobs", Func = function()
		M();
		h:Notify({ Title = "Auto Teleport", Description = "Lista de mobs atualizada!", Time = 2 });
	end });
C:AddDropdown("TeleportPosition", {
	Values = {
		"Behind",
		"Front",
		"On Top",
		"Left",
		"Right",
	},
	Default = "Behind",
	Text = "Position",
	Tooltip = "Posi\195\167\195\163o relativa ao mob",
});
C:AddSlider("TeleportDistance", {
	Text = "Distance",
	Default = 5,
	Min = 1,
	Max = 20,
	Rounding = 1,
	Suffix = " studs",
	Tooltip = "Dist\195\162ncia do mob",
});
C:AddSlider("TeleportSpeed", {
	Text = "Teleport Speed",
	Default = 500,
	Min = 100,
	Max = 5000,
	Rounding = 0,
	Suffix = " ms",
	Tooltip = "Intervalo entre teleports em milissegundos",
});
C:AddToggle("AutoTeleportToggle", {
	Text = "Auto Teleport",
	Default = false,
	Tooltip = "Teleporta automaticamente para o mob selecionado",
	Callback = function(m)
		y = m;
	end,
});
local mp = P.AutoFarm:AddLeftGroupbox("Auto Stats");
local function hp()
	local m, h = pcall(function()
			return p:InvokeServer();
		end);
	if m and h then
		return h;
	end;
	return nil;
end;
local function wp()
	local m = ((X:WaitForChild("LevelHolder")):WaitForChild("Level")).Value;
	local h = require(game.ReplicatedStorage.GuiUtils.Rebirth);
	local w = require(game.ReplicatedStorage.Config.RebirthHelper);
	local Z = w.getFakeUpgradeLevel(h.getNowLevel());
	return (((((m or 1)) - 1) + Z)) * 4;
end;
local function Zp(m)
	local h = 0;
	if m then
		for m, w in m do
			h = h + w;
		end;
	end;
	return h;
end;
local function Up()
	local m = hp();
	if not m then
		return 0;
	end;
	return math.max(wp() - Zp(m), 0);
end;
local function Vp(m, h)
	local w = Up();
	if w <= 0 then
		return;
	end;
	local Z = math.min(h or 1, w);
	if Z > 0 then
		S:FireServer(m, Z);
	end;
end;
mp:AddDropdown("StatsMode", {
	Values = {
		"All",
		"Damage",
		"Defense",
		"Health",
	},
	Default = "All",
	Text = "Mode",
	Tooltip = "Qual stat upar: All = distribui, ou escolhe um espec\195\173fico",
});
mp:AddSlider("StatsAmount", {
	Text = "Points per Click",
	Default = 1,
	Min = 1,
	Max = 100,
	Rounding = 0,
	Tooltip = "Quantidade de pontos para adicionar de cada vez",
});
mp:AddSlider("StatsDelay", {
	Text = "Upgrade Delay",
	Default = 500,
	Min = 100,
	Max = 3000,
	Rounding = 0,
	Suffix = " ms",
	Tooltip = "Intervalo entre upgrades em milissegundos",
});
mp:AddToggle("AutoStatsToggle", {
	Text = "Auto Stats",
	Default = false,
	Tooltip = "Upa stats automaticamente",
	Callback = function(m)
		t = m;
		if m then
			a = 0;
		end;
	end,
});
mp:AddDivider();
local qp = mp:AddLabel({ Text = "Pontos restantes: ?", DoesWrap = false, Size = 14 });
V.AutoStatsToggle:OnChanged(function()
	if V.AutoStatsToggle.Value then
		qp:SetText("Pontos restantes: " .. Up());
		h:Notify({ Title = "Auto Stats", Description = "Ativado!", Time = 2 });
	else
		qp:SetText("Auto Stats: Desligado");
		h:Notify({ Title = "Auto Stats", Description = "Desativado!", Time = 2 });
	end;
end);
local Pp = C:AddLabel({ Text = "Alvo: Nenhum", DoesWrap = false, Size = 14 });
V.AutoTeleportToggle:OnChanged(function()
	if V.AutoTeleportToggle.Value then
		local m = U.SelectedMob.Value or "Nenhum";
		Pp:SetText("Alvo: " .. m);
	else
		Pp:SetText("Alvo: Desligado");
	end;
end);
local Ep = P.AutoFarm:AddRightGroupbox("Auto Skills");
Ep:AddDropdown("AutoSkillSlot", {
	Values = {
		"All",
		"Slot 1",
		"Slot 2",
		"Slot 3",
	},
	Default = "All",
	Text = "Skill Slot",
	Tooltip = "Qual slot de skill usar",
});
Ep:AddSlider("SkillCooldownDelay", {
	Text = "Skill Delay",
	Default = 1000,
	Min = 200,
	Max = 5000,
	Rounding = 0,
	Suffix = " ms",
	Tooltip = "Delay entre skills em milissegundos",
});
Ep:AddToggle("AutoSkillsToggle", {
	Text = "Auto Skills",
	Default = false,
	Tooltip = "Usa skills automaticamente",
	Callback = function(m)
		c = m;
		if m then
			O = 0;
		end;
	end,
});
Ep:AddToggle("AllMobsHit", { Text = "All Mobs Hit", Default = false, Tooltip = "Faz a skill S1 acertar TODOS os mobs vivos (substitui a lista de alvos)" });
Ep:AddDivider();
local up = Ep:AddLabel({ Text = "Skills: Desligado", DoesWrap = false, Size = 14 });
V.AutoSkillsToggle:OnChanged(function()
	if V.AutoSkillsToggle.Value then
		up:SetText("Skills: Ativado");
		h:Notify({ Title = "Auto Skills", Description = "Ativado!", Time = 2 });
	else
		up:SetText("Skills: Desligado");
		h:Notify({ Title = "Auto Skills", Description = "Desativado!", Time = 2 });
	end;
end);
local Xp = P.AutoFarm:AddRightGroupbox("Auto Pickup");
Xp:AddSlider("PickupDelay", {
	Text = "Pickup Delay",
	Default = 300,
	Min = 100,
	Max = 2000,
	Rounding = 0,
	Suffix = " ms",
	Tooltip = "Intervalo entre coletas em milissegundos",
});
Xp:AddSlider("PickupRange", {
	Text = "Max Range",
	Default = 50,
	Min = 10,
	Max = 200,
	Rounding = 0,
	Suffix = " studs",
	Tooltip = "Dist\195\162ncia m\195\161xima para coletar itens",
});
Xp:AddToggle("AutoPickupToggle", {
	Text = "Auto Pickup",
	Default = false,
	Tooltip = "Coleta itens automaticamente",
	Callback = function(m)
		l = m;
		if m then
			I = 0;
		end;
	end,
});
Xp:AddDivider();
local dp = Xp:AddLabel({ Text = "Itens: 0", DoesWrap = false, Size = 14 });
local rp = P.AutoFarm:AddRightGroupbox("Informa\195\167\195\181es");
rp:AddLabel({ Text = "Kill Aura autom\195\161tico para mobs pr\195\179ximos.\n\nAuto Teleport segue o mob selecionado. Se morrer, vai para outro com o mesmo nome.", DoesWrap = true, Size = 13 });
rp:AddDivider();
local Sp = rp:AddLabel({ Text = "Mobs detectados: 0", DoesWrap = false, Size = 14 });
local pp = rp:AddLabel({ Text = "Alvo atual: Nenhum", DoesWrap = false, Size = 14 });
task.spawn(function()
	while task.wait() do
		if h.Unloaded then
			break;
		end;
		local m = L(U.AttackRange.Value);
		Sp:SetText("Mobs detectados: " .. #m);
		if b then
			local h = tick();
			local w = U.AttackDelay.Value;
			local Z = w / 1000;
			if h - G >= Z then
				if #m > 0 then
					d:FireServer(m);
					G = h;
				end;
			end;
		end;
		if t then
			local m = tick();
			local h = ((U.StatsDelay.Value or 500)) / 1000;
			if m - a >= h then
				local h = U.StatsMode.Value or "All";
				local w = U.StatsAmount.Value or 1;
				local Z = hp();
				local V = 0;
				if Z then
					V = math.max(wp() - Zp(Z), 0);
				end;
				qp:SetText("Pontos restantes: " .. V);
				if V > 0 then
					local w = U.StatsAmount.Value or 1;
					if h == "All" then
						local m = Z and Z.Damage or 0;
						local h = Z and Z.Defense or 0;
						local U = Z and Z.Health or 0;
						local q = wp();
						local P = q / 2;
						local E = q / 4;
						local u = math.clamp(P - m, 0, V);
						if u > 0 then
							Vp("Damage", math.min(w, u));
						else
							local m = math.clamp(E - h, 0, V);
							if m > 0 then
								Vp("Defense", math.min(w, m));
							else
								Vp("Health", math.min(w, V));
							end;
						end;
					else
						Vp(h, w);
					end;
					a = m;
				end;
			end;
		end;
		if l then
			local m = tick();
			local h = ((U.PickupDelay.Value or 300)) / 1000;
			if m - I >= h then
				local h = X.Character;
				if h and h:FindFirstChild("HumanoidRootPart") then
					local m = h.HumanoidRootPart.Position;
					local w = U.PickupRange.Value or 50;
					local Z = R:GetChildren();
					dp:SetText("Itens: " .. #Z);
					if #Z > 0 then
						local U = h.HumanoidRootPart.CFrame;
						local V = nil;
						local q = math.huge;
						for h, Z in Z do
							if Z:IsA("BasePart") then
								local h = ((Z.Position - m)).Magnitude;
								if h < q and h <= w then
									q = h;
									V = Z;
								end;
							end;
						end;
						if V then
							o(V.Position + Vector3.new(0, 2, 0));
							task.wait(.1);
							j:SendKeyEvent(true, Enum.KeyCode.E, false, game);
							task.wait(.05);
							j:SendKeyEvent(false, Enum.KeyCode.E, false, game);
							task.wait(.15);
							if h and h:FindFirstChild("HumanoidRootPart") then
								h.HumanoidRootPart.CFrame = U;
							end;
						end;
					end;
				end;
				I = m;
			end;
		end;
		if c then
			local m = tick();
			local h = ((U.SkillCooldownDelay.Value or 1000)) / 1000;
			if m - O >= h then
				local h = U.AutoSkillSlot.Value or "All";
				local w = e();
				local Z = false;
				if h == "All" then
					for m, h in w do
						if not n(h) then
							pcall(function()
								T:FireServer(h);
							end);
							Z = true;
						end;
					end;
				else
					local m = tonumber(string.match(h, "%d+"));
					if m and w[m] then
						local h = w[m];
						if not n(h) then
							pcall(function()
								T:FireServer(h);
							end);
							Z = true;
						end;
					end;
				end;
				if Z then
					O = m;
					up:SetText("Skills: Ativado - Usando!");
				else
					up:SetText("Skills: Ativado - Cooldown");
				end;
			end;
		end;
		if y then
			local m = tick();
			local h = U.TeleportSpeed.Value or 500;
			local w = h / 1000;
			if m - Q >= w then
				local h = U.SelectedMob.Value;
				if h then
					local m = z(h);
					if m then
						local h = U.TeleportPosition.Value or "Behind";
						local w = U.TeleportDistance.Value or 5;
						local Z = N(m, h, w);
						if Z then
							o(Z);
						end;
						local V = m.Humanoid.DisplayName;
						pp:SetText("Alvo atual: " .. V);
					else
						pp:SetText("Alvo atual: Procurando...");
					end;
				end;
				Q = m;
			end;
		end;
		if K then
			local m = tick();
			local h = ((U.EggOpenDelay.Value or 1000)) / 1000;
			if m - f >= h then
				local h = U.SelectedEgg.Value;
				if h then
					local w = pcall(function()
							local m = H:InvokeServer(h, 1);
							if m then
								B:SetText("Auto Eggs: Aberto!");
							end;
						end);
					if w then
						f = m;
					end;
				else
					B:SetText("Auto Eggs: Sem ovo selecionado");
				end;
			end;
		end;
	end;
end);
pcall(function()
	k = require((E:WaitForChild("Config")):WaitForChild("LuckHelper"));
end);
local function Rp()
	local m = {};
	local h = workspace:FindFirstChild("Eggs");
	if h then
		for h, w in h:GetChildren() do
			table.insert(m, w.Name);
		end;
	end;
	if #m == 0 and k then
		pcall(function()
			if k.getList then
				local h = k.getList();
				for h, w in pairs(h) do
					table.insert(m, h);
				end;
			end;
		end);
	end;
	table.sort(m);
	return m;
end;
local Tp = P.Auto:AddRightGroupbox("Auto Open Eggs");
Tp:AddDropdown("SelectedEgg", {
	Text = "Egg",
	Values = Rp(),
	Default = nil,
	AllowNull = true,
	Tooltip = "Selecione o ovo para abrir automaticamente",
});
Tp:AddButton({ Text = "Refresh Eggs", Func = function()
		local m = Rp();
		U.SelectedEgg:SetValues(m);
		if #m > 0 and not U.SelectedEgg.Value then
			U.SelectedEgg:SetValue(m[1]);
		end;
		h:Notify({ Title = "Auto Eggs", Description = "Lista de ovos atualizada! (" .. (#m .. " encontrados)"), Time = 2 });
	end });
Tp:AddSlider("EggOpenDelay", {
	Text = "Open Delay",
	Default = 1000,
	Min = 200,
	Max = 5000,
	Rounding = 0,
	Suffix = " ms",
	Tooltip = "Intervalo entre aberturas de ovo",
});
Tp:AddToggle("AutoEggsToggle", {
	Text = "Auto Open Eggs",
	Default = false,
	Tooltip = "Abre o ovo selecionado automaticamente",
	Callback = function(m)
		K = m;
		if m then
			f = 0;
		end;
	end,
});
Tp:AddDivider();
local Wp = Tp:AddLabel({ Text = "Auto Eggs: Desligado", DoesWrap = false, Size = 14 });
V.AutoEggsToggle:OnChanged(function()
	if V.AutoEggsToggle.Value then
		Wp:SetText("Auto Eggs: Ativado");
		h:Notify({ Title = "Auto Eggs", Description = "Ativado!", Time = 2 });
	else
		Wp:SetText("Auto Eggs: Desligado");
		h:Notify({ Title = "Auto Eggs", Description = "Desativado!", Time = 2 });
	end;
end);
local Hp = P["UI Settings"]:AddLeftGroupbox("Menu");
(Hp:AddLabel("Menu bind")):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" });
h.ToggleKeybind = U.MenuKeybind;
w:SetLibrary(h);
Z:SetLibrary(h);
Z:IgnoreThemeSettings();
Z:SetIgnoreIndexes({ "MenuKeybind" });
w:SetFolder("SlimHub");
Z:SetFolder("SlimHub");
Z:BuildConfigSection(P["UI Settings"]);
w:ApplyToTab(P["UI Settings"]);
Z:LoadAutoloadConfig();
h:OnUnload(function()
	if A then
		A:Disconnect();
		A = nil;
	end;
	b = false;
	y = false;
end);
h:Notify({ Title = "Slim Hub", Description = "feito por chad | Painel carregado!", Time = 3 });
task.wait(2);
M();