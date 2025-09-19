module("modules.logic.fight.entity.comp.FightVariantHeartComp", package.seeall)

local var_0_0 = class("FightVariantHeartComp", LuaCompBase)

var_0_0.VariantKey = {
	"_STYLIZATIONMOSTER_ON",
	"_STYLIZATIONMOSTER2_ON",
	"_STYLIZATIONMOSTER3_ON",
	"_STYLIZATIONMOSTER2_ON",
	"_STYLE_JOINT_ON",
	"_STYLE_RAIN_STORM_ON",
	"_STYLE_ASSIST_ON",
	"_STYLIZATIONMOSTER4_ON",
	"_STYLE_SHADOW_ON"
}

local var_0_1 = "_NoiseMap3"
local var_0_2 = {
	"noise_01_manual",
	"noise_02_manual",
	"",
	"noise_03_manual",
	"noise_sty_joint2_manual",
	"textures/style_rain_strom_manual",
	"textures/style_assist_noise_manual",
	"textures/noise_05_manual",
	""
}
local var_0_3 = "_Pow"
local var_0_4 = {
	{
		0.4,
		0.9,
		1.2,
		2.4
	},
	[3] = {
		0.08,
		0.09,
		0.1,
		0.1
	},
	[4] = {
		0,
		0,
		0,
		0
	},
	[5] = {
		0.4,
		0.9,
		1.2,
		2.4
	}
}
local var_0_5 = "_StyOffset"
local var_0_6 = {
	0,
	0,
	0,
	1,
	0
}
local var_0_7 = {
	[8] = "roleeffects/roleeffect_glitch"
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._hostEntity = arg_1_1
end

function var_0_0.setEntity(arg_2_0, arg_2_1)
	arg_2_0._hostEntity = arg_2_1

	arg_2_0:_change()
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, arg_3_0._onMatChange, arg_3_0, LuaEventSystem.Low)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, arg_4_0._onMatChange, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_4_0._onSpineLoaded, arg_4_0)
end

function var_0_0._onMatChange(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == arg_5_0.entity.id then
		arg_5_0:_change()
	end
end

function var_0_0._onSpineLoaded(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.entity.spine then
		arg_6_0:_change()
	end
end

function var_0_0._change(arg_7_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if not arg_7_0._hostEntity or not arg_7_0._hostEntity:getMO() then
		return
	end

	local var_7_0 = arg_7_0.entity.buff and arg_7_0.entity.buff:getBuffMatName()
	local var_7_1

	if not string.nilorempty(var_7_0) then
		local var_7_2 = var_7_1 and var_7_1:getCO()

		if var_7_2 then
			local var_7_3 = lua_buff_mat_variant.configDict[var_7_2.typeId]

			if var_7_3 then
				local var_7_4 = var_7_3.variant

				if var_7_4 and var_0_0.VariantKey[var_7_4] then
					arg_7_0:_changeVariant(var_7_4)

					return
				end
			end
		end
	end

	local var_7_5 = arg_7_0._hostEntity:getMO()
	local var_7_6 = var_7_5 and var_7_5:getCO()
	local var_7_7 = var_7_6 and var_7_6.heartVariantId

	if not var_7_7 or not var_0_0.VariantKey[var_7_7] then
		return
	end

	if gohelper.isNil(arg_7_0.entity.go) then
		return
	end

	arg_7_0:_changeVariant(var_7_7)
end

function var_0_0._changeVariant(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.VariantKey[arg_8_1]
	local var_8_1 = var_0_2[arg_8_1]
	local var_8_2 = var_0_6[arg_8_1]
	local var_8_3 = FightHelper.getModelSize(arg_8_0.entity)
	local var_8_4 = var_0_4[arg_8_1] and var_0_4[arg_8_1][var_8_3]
	local var_8_5 = arg_8_0.entity.spineRenderer:getReplaceMat()

	if not var_8_5 then
		return
	end

	if var_8_0 then
		var_8_5:EnableKeyword(var_8_0)
	end

	if var_8_4 and var_8_5:HasProperty(var_0_3) then
		local var_8_6 = var_8_5:GetVector(var_0_3)

		var_8_6.w = var_8_4

		var_8_5:SetVector(var_0_3, var_8_6)
	end

	if var_8_2 then
		var_8_5:SetFloat(var_0_5, var_8_2)
	end

	if not string.nilorempty(var_8_1) then
		arg_8_0._texturePath = ResUrl.getRoleSpineMatTex(var_8_1)

		loadAbAsset(arg_8_0._texturePath, false, arg_8_0._onLoadCallback, arg_8_0)
	end

	local var_8_7 = var_0_7[arg_8_1]

	if not var_8_7 then
		arg_8_0:clearLoader()
		arg_8_0:clearEffect()

		arg_8_0.curEffectRes = nil
	elseif not arg_8_0.effectWrap or arg_8_0.curEffectRes ~= var_8_7 then
		arg_8_0.curEffectRes = var_8_7

		arg_8_0:clearLoader()

		arg_8_0.effectLoader = MultiAbLoader.New()

		local var_8_8 = FightHelper.getEffectUrlWithLod(var_8_7)
		local var_8_9 = FightHelper.getEffectAbPath(var_8_8)

		arg_8_0.effectLoader:addPath(var_8_9)
		arg_8_0.effectLoader:startLoad(arg_8_0.onEffectLoaded, arg_8_0)
	end
end

function var_0_0.onEffectLoaded(arg_9_0)
	arg_9_0.effectWrap = arg_9_0.entity.effect:addHangEffect(arg_9_0.curEffectRes, ModuleEnum.SpineHangPointRoot)

	arg_9_0.effectWrap:setLocalPos(0, 0, 0)
end

function var_0_0._onLoadCallback(arg_10_0, arg_10_1)
	if arg_10_1.IsLoadSuccess then
		arg_10_0._assetItem = arg_10_1

		arg_10_1:Retain()

		local var_10_0 = arg_10_1:GetResource(arg_10_0._texturePath)

		arg_10_0.entity.spineRenderer:getReplaceMat():SetTexture(var_0_1, var_10_0)
	end
end

function var_0_0.clearEffect(arg_11_0)
	if arg_11_0.effectWrap then
		arg_11_0.entity.effect:removeEffect(arg_11_0.effectWrap)

		arg_11_0.effectWrap = nil
	end
end

function var_0_0.clearLoader(arg_12_0)
	if arg_12_0.effectLoader then
		arg_12_0.effectLoader:dispose()

		arg_12_0.effectLoader = nil
	end
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:clearLoader()
	arg_13_0:clearEffect()

	arg_13_0.curEffectRes = nil

	if arg_13_0._assetItem then
		arg_13_0._assetItem:Release()

		arg_13_0._assetItem = nil
	end
end

return var_0_0
