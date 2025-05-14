module("modules.logic.gm.view.Checker_Hero", package.seeall)

local var_0_0 = class("Checker_Hero", Checker_Base)

var_0_0.Type = {
	Live2d = 1,
	Spine = 0
}

local var_0_1 = {}
local var_0_2 = {}

for iter_0_0, iter_0_1 in ipairs(lua_skin.configList) do
	local var_0_3 = iter_0_1.id
	local var_0_4 = iter_0_1.characterId

	if not string.nilorempty(iter_0_1.verticalDrawing) then
		var_0_2[ResUrl.getRolesPrefabStory(iter_0_1.verticalDrawing)] = var_0_3
	end

	if not string.nilorempty(iter_0_1.live2d) then
		var_0_2[ResUrl.getLightLive2d(iter_0_1.live2d)] = var_0_3
	end

	var_0_1[var_0_4] = var_0_1[var_0_4] or {}

	table.insert(var_0_1[var_0_4], iter_0_1)
end

local function var_0_5(arg_1_0)
	return lua_character_voice.configDict[arg_1_0]
end

local function var_0_6(arg_2_0, arg_2_1)
	return var_0_1[arg_2_0][arg_2_1]
end

local function var_0_7(arg_3_0)
	local var_3_0 = string.match(arg_3_0, ".+/([^/]*%.%w+)$")
	local var_3_1 = string.match(var_3_0, "(%w+)")

	return assert(tonumber(var_3_1), "invalid resPath: " .. arg_3_0)
end

local function var_0_8(arg_4_0, arg_4_1)
	if not arg_4_0 or not arg_4_1 then
		return false
	end

	local var_4_0 = arg_4_0.skins

	if string.nilorempty(var_4_0) then
		return false
	end

	return string.find(var_4_0, arg_4_1)
end

local function var_0_9(arg_5_0)
	local var_5_0 = arg_5_0.class.__cname

	if var_5_0 == "GuiSpine" or var_5_0 == "LightSpine" then
		return var_0_0.Type.Spine, arg_5_0, arg_5_0:getResPath()
	elseif var_5_0 == "GuiLive2d" or var_5_0 == "LightLive2d" then
		return var_0_0.Type.Live2d, arg_5_0, arg_5_0:getResPath()
	end
end

local function var_0_10(arg_6_0)
	local var_6_0 = arg_6_0._curModel

	if not var_6_0 then
		return
	end

	return var_0_9(var_6_0)
end

local function var_0_11(arg_7_0)
	if not arg_7_0 then
		return
	end

	if arg_7_0.class.__cname ~= "GuiModelAgent" and false then
		-- block empty
	end

	do return var_0_10(arg_7_0) end

	if false then
		return var_0_9(arg_7_0)
	end
end

function var_0_0.ctor(arg_8_0, arg_8_1)
	Checker_Base.ctor(arg_8_0)
	arg_8_0:reset(arg_8_1)
end

function var_0_0.reset(arg_9_0, arg_9_1)
	arg_9_0._heroId = arg_9_1
	arg_9_0._heroCO = HeroConfig.instance:getHeroCO(arg_9_1)
	arg_9_0._resPath = ""
	arg_9_0._skinId = false
end

function var_0_0._logError(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or ""

	return string.format("%s%s(%s)", arg_10_1, arg_10_0:heroName(), tostring(arg_10_0:heroId()))
end

function var_0_0.exec(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 then
		arg_11_0:reset(arg_11_2)
	end

	local var_11_0, var_11_1, var_11_2 = var_0_11(arg_11_1)

	arg_11_0._resPath = var_11_2

	if not var_11_0 or not var_11_1 then
		arg_11_0:_logError("[_getInfoFromObj]: ")

		return
	end

	if var_11_0 == var_0_0.Type.Spine then
		arg_11_0:_onExec_Spine(var_11_1)
	elseif var_11_0 == var_0_0.Type.Live2d then
		arg_11_0:_onExec_Live2d(var_11_1)
	else
		assert(false, "unsupported Checker_Hero.Type!! type=" .. tostring(var_11_0))
	end
end

function var_0_0._onExec_Spine(arg_12_0, arg_12_1)
	assert(false, "please override this function!")
end

function var_0_0._onExec_Live2d(arg_13_0, arg_13_1)
	assert(false, "please override this function!")
end

function var_0_0.heroId(arg_14_0)
	return arg_14_0._heroId
end

function var_0_0.heroCO(arg_15_0)
	return arg_15_0._heroCO
end

function var_0_0.heroName(arg_16_0)
	return arg_16_0._heroCO.name
end

function var_0_0.resPath(arg_17_0)
	return arg_17_0._resPath
end

function var_0_0.skinId(arg_18_0)
	assert(not string.nilorempty(arg_18_0._resPath), "please call exec first!!")

	if not arg_18_0._skinId then
		arg_18_0._skinId = var_0_2[arg_18_0._resPath] or var_0_7(arg_18_0._resPath)
	end

	return arg_18_0._skinId
end

function var_0_0.characterVoiceCO(arg_19_0)
	return var_0_5(arg_19_0._heroId)
end

function var_0_0.characterSkinCO(arg_20_0)
	local var_20_0 = arg_20_0:skinId()

	return var_0_6[arg_20_0._heroId][var_20_0]
end

function var_0_0.skincharacterVoiceCOList(arg_21_0)
	local var_21_0 = arg_21_0:skinId()

	return arg_21_0:_skincharacterVoiceCOList(var_21_0)
end

function var_0_0.heroMO(arg_22_0)
	return HeroModel.instance:getByHeroId(arg_22_0._heroId)
end

function var_0_0.heroMOSkinId(arg_23_0)
	local var_23_0 = arg_23_0:heroMO()

	if var_23_0 then
		return var_23_0.skin
	end
end

function var_0_0.heroMOSkinCO(arg_24_0)
	local var_24_0 = arg_24_0:heroMOSkinId()

	if var_24_0 then
		return var_0_6[arg_24_0._heroId][var_24_0]
	end
end

function var_0_0.heroMOSkincharacterVoiceCOList(arg_25_0)
	return arg_25_0:_skincharacterVoiceCOList(arg_25_0:heroMOSkinId())
end

function var_0_0._skincharacterVoiceCOList(arg_26_0, arg_26_1)
	local var_26_0 = {}

	if not arg_26_1 then
		return var_26_0
	end

	local var_26_1 = arg_26_0:characterVoiceCO()

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		if var_0_8(iter_26_1, arg_26_1) then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

return var_0_0
