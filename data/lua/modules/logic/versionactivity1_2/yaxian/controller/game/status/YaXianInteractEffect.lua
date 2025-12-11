module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractEffect", package.seeall)

local var_0_0 = class("YaXianInteractEffect", UserDataDispose)

var_0_0.EffectPath = {
	[YaXianGameEnum.EffectType.Fight] = YaXianGameEnum.SceneResPath.FightEffect,
	[YaXianGameEnum.EffectType.Assassinate] = YaXianGameEnum.SceneResPath.AssassinateEffect,
	[YaXianGameEnum.EffectType.Die] = YaXianGameEnum.SceneResPath.DieEffect,
	[YaXianGameEnum.EffectType.FightSuccess] = YaXianGameEnum.SceneResPath.FightSuccessEffect,
	[YaXianGameEnum.EffectType.PlayerAssassinateEffect] = YaXianGameEnum.SceneResPath.PlayerAssassinateEffect
}
var_0_0.EffectAudio = {
	[YaXianGameEnum.EffectType.Assassinate] = AudioEnum.YaXian.Assassinate,
	[YaXianGameEnum.EffectType.PlayerAssassinateEffect] = AudioEnum.YaXian.Assassinate,
	[YaXianGameEnum.EffectType.Fight] = AudioEnum.YaXian.Fight,
	[YaXianGameEnum.EffectType.Die] = AudioEnum.YaXian.Die
}

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.interactItem = arg_2_1
	arg_2_0.interactMo = arg_2_1.interactMo
	arg_2_0.effectGoContainer = arg_2_1.effectGoContainer
	arg_2_0.config = arg_2_0.interactMo.config
	arg_2_0.effectGoDict = arg_2_0:getUserDataTb_()
	arg_2_0.assetItemList = arg_2_0:getUserDataTb_()
	arg_2_0.loadedEffectList = {}
end

function var_0_0.showEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0.interactItem:isDelete() then
		if arg_3_0.doneCallback then
			arg_3_0.doneCallback(arg_3_0.callbackObj)
		end

		return
	end

	arg_3_0.showEffectType = arg_3_0:getInputEffectType(arg_3_1)
	arg_3_0.doneCallback = arg_3_2
	arg_3_0.callbackObj = arg_3_3

	if not arg_3_0.effectGoDict[arg_3_0.showEffectType] then
		arg_3_0:loadEffect()

		return
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, false)
	arg_3_0:_showEffect()
end

function var_0_0.getInputEffectType(arg_4_0, arg_4_1)
	if arg_4_1 == YaXianGameEnum.EffectType.Assassinate and arg_4_0.config.interactType == YaXianGameEnum.InteractType.Player then
		return YaXianGameEnum.EffectType.PlayerAssassinateEffect
	end

	return arg_4_1
end

function var_0_0._showEffect(arg_5_0)
	local var_5_0 = arg_5_0.effectGoDict[arg_5_0.showEffectType]

	gohelper.setActive(var_5_0, false)
	gohelper.setActive(var_5_0, true)
	YaXianGameController.instance:playEffectAudio(var_0_0.EffectAudio[arg_5_0.showEffectType])
	TaskDispatcher.runDelay(arg_5_0.onEffectDone, arg_5_0, YaXianGameEnum.EffectDuration[arg_5_0.showEffectType] or YaXianGameEnum.DefaultEffectDuration)
end

function var_0_0.onEffectDone(arg_6_0)
	local var_6_0 = arg_6_0.effectGoDict[arg_6_0.showEffectType]

	gohelper.setActive(var_6_0, false)

	if arg_6_0.showEffectType == YaXianGameEnum.EffectType.Die then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.DeleteInteractObj, arg_6_0.interactItem.id)
	end

	if arg_6_0.doneCallback then
		arg_6_0.doneCallback(arg_6_0.callbackObj)
	end
end

function var_0_0.loadEffect(arg_7_0)
	local var_7_0 = arg_7_0.showEffectType

	if tabletool.indexOf(arg_7_0.loadedEffectList, var_7_0) then
		return
	end

	table.insert(arg_7_0.loadedEffectList, var_7_0)

	local var_7_1 = var_0_0.EffectPath[var_7_0]

	loadAbAsset(var_7_1, true, arg_7_0._onLoadCallback, arg_7_0)
end

function var_0_0._onLoadCallback(arg_8_0, arg_8_1)
	if arg_8_1.IsLoadSuccess then
		table.insert(arg_8_0.assetItemList, arg_8_1)
		arg_8_1:Retain()

		local var_8_0 = gohelper.clone(arg_8_1:GetResource(), arg_8_0.effectGoContainer)

		arg_8_0.effectGoDict[arg_8_0.showEffectType] = var_8_0

		gohelper.setActive(var_8_0, false)
		arg_8_0:showEffect(arg_8_0.showEffectType, arg_8_0.doneCallback, arg_8_0.callbackObj)
	end
end

function var_0_0.cancelTask(arg_9_0)
	local var_9_0 = arg_9_0.effectGoDict[arg_9_0.showEffectType]

	gohelper.setActive(var_9_0, false)
	TaskDispatcher.cancelTask(arg_9_0.onEffectDone, arg_9_0)
end

function var_0_0.dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.loadedEffectList) do
		removeAssetLoadCb(var_0_0.EffectPath[iter_10_1], arg_10_0._onLoadCallback, arg_10_0)
	end

	if arg_10_0.assetItemList then
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.assetItemList) do
			iter_10_3:Release()
		end

		arg_10_0.assetItemList = nil
	end

	arg_10_0:cancelTask()
	arg_10_0:__onDispose()
end

return var_0_0
