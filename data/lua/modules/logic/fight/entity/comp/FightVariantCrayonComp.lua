module("modules.logic.fight.entity.comp.FightVariantCrayonComp", package.seeall)

local var_0_0 = class("FightVariantCrayonComp", LuaCompBase)
local var_0_1 = {
	m_s62_jzsylb = true
}
local var_0_2 = "_STYLIZATIONPLAYER_ON"
local var_0_3 = "_NoiseMap3"
local var_0_4 = "_ShadowMap"
local var_0_5 = "crayonmap1_manual"
local var_0_6 = "crayonmap2_manual"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, arg_2_0._onMatChange, arg_2_0, LuaEventSystem.Low)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, arg_3_0._onMatChange, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_3_0._onSpineLoaded, arg_3_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
end

function var_0_0._onMatChange(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == arg_4_0.entity.id then
		arg_4_0:_change()
	end
end

function var_0_0._onSpineLoaded(arg_5_0, arg_5_1)
	if arg_5_1 == arg_5_0.entity.spine then
		arg_5_0:_change()
	end
end

function var_0_0._onLevelLoaded(arg_6_0)
	if arg_6_0:_needChange() then
		arg_6_0:_change()
	else
		local var_6_0 = arg_6_0.entity.spineRenderer:getReplaceMat()

		if not var_6_0 then
			return
		end

		var_6_0:DisableKeyword(var_0_2)
	end
end

function var_0_0._needChange(arg_7_0)
	local var_7_0 = GameSceneMgr.instance:getCurScene():getCurLevelId()
	local var_7_1 = lua_scene_level.configDict[var_7_0]

	return var_0_1[var_7_1.resName] ~= nil
end

function var_0_0._change(arg_8_0)
	if not arg_8_0:_needChange() then
		return
	end

	local var_8_0 = arg_8_0.entity.spineRenderer:getReplaceMat()

	if not var_8_0 then
		return
	end

	var_8_0:EnableKeyword(var_0_2)

	arg_8_0._noiceMapPath = ResUrl.getRoleSpineMatTex(var_0_5)
	arg_8_0._shadowMapPath = ResUrl.getRoleSpineMatTex(var_0_6)

	loadAbAsset(arg_8_0._noiceMapPath, false, arg_8_0._onLoadCallback1, arg_8_0)
	loadAbAsset(arg_8_0._shadowMapPath, false, arg_8_0._onLoadCallback2, arg_8_0)
end

function var_0_0._onLoadCallback1(arg_9_0, arg_9_1)
	if arg_9_1.IsLoadSuccess then
		arg_9_0._assetItem1 = arg_9_1

		arg_9_1:Retain()

		local var_9_0 = arg_9_1:GetResource(arg_9_0._noiceMapPath)

		arg_9_0.entity.spineRenderer:getReplaceMat():SetTexture(var_0_3, var_9_0)
	end
end

function var_0_0._onLoadCallback2(arg_10_0, arg_10_1)
	if arg_10_1.IsLoadSuccess then
		arg_10_0._assetItem2 = arg_10_1

		arg_10_1:Retain()

		local var_10_0 = arg_10_1:GetResource(arg_10_0._shadowMapPath)

		arg_10_0.entity.spineRenderer:getReplaceMat():SetTexture(var_0_4, var_10_0)
	end
end

function var_0_0.onDestroy(arg_11_0)
	if arg_11_0._assetItem1 then
		arg_11_0._assetItem1:Release()

		arg_11_0._assetItem1 = nil
	end

	if arg_11_0._assetItem2 then
		arg_11_0._assetItem2:Release()

		arg_11_0._assetItem2 = nil
	end
end

return var_0_0
