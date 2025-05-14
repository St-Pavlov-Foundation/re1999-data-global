module("modules.logic.fight.view.indicator.FightIndicatorView", package.seeall)

local var_0_0 = class("FightIndicatorView", FightIndicatorBaseView)

var_0_0.PrefabPath = "ui/sceneui/fight/seasoncelebritycardi.prefab"
var_0_0.EffectDuration = 1.667
var_0_0.EffectDurationForDot = 0.8
var_0_0.MaxIndicatorCount = 5

function var_0_0.initView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.initView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.totalIndicatorNum = var_0_0.MaxIndicatorCount
	arg_1_0.goIndicatorContainer = gohelper.findChild(arg_1_0.goIndicatorRoot, "fight_indicator")
end

function var_0_0.startLoadPrefab(arg_2_0)
	gohelper.setActive(arg_2_0.goIndicatorContainer, true)

	arg_2_0.loader = PrefabInstantiate.Create(arg_2_0.goIndicatorContainer)

	arg_2_0.loader:startLoad(var_0_0.PrefabPath, arg_2_0.loadCallback, arg_2_0)
end

function var_0_0.loadCallback(arg_3_0)
	arg_3_0.loadDone = true
	arg_3_0.instanceGo = arg_3_0.loader:getInstGO()

	arg_3_0:initNode()
	arg_3_0:onIndicatorChange()
end

function var_0_0.initNode(arg_4_0)
	arg_4_0.init = true
	arg_4_0.goDownOne = gohelper.findChild(arg_4_0.instanceGo, "down_one")
	arg_4_0.goDownAll = gohelper.findChild(arg_4_0.instanceGo, "down_all")
	arg_4_0.goUpOne = gohelper.findChild(arg_4_0.instanceGo, "up_one")
	arg_4_0.goUpAll = gohelper.findChild(arg_4_0.instanceGo, "up_all")
	arg_4_0.pointContainer = gohelper.findChild(arg_4_0.instanceGo, "pointContainer")

	local var_4_0 = gohelper.findChild(arg_4_0.instanceGo, "pointContainer/dot_item")

	arg_4_0.goDotItemList = {}

	table.insert(arg_4_0.goDotItemList, arg_4_0:createDotItem(var_4_0))

	for iter_4_0 = 2, arg_4_0.totalIndicatorNum do
		var_4_0 = gohelper.cloneInPlace(var_4_0)

		table.insert(arg_4_0.goDotItemList, arg_4_0:createDotItem(var_4_0))
	end

	arg_4_0.simageIcon = gohelper.findChildSingleImage(arg_4_0.instanceGo, "card/#go_rare5/image_icon")
	arg_4_0.simageSignature = gohelper.findChildSingleImage(arg_4_0.instanceGo, "card/#go_rare5/simage_signature")

	local var_4_1 = gohelper.findChild(arg_4_0.instanceGo, "card/#go_rare5/image_career")

	gohelper.setActive(var_4_1, false)
	arg_4_0:loadImage()
end

function var_0_0.createDotItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.goDot = arg_5_1
	var_5_0.goDarkIcon = gohelper.findChild(arg_5_1, "dark_icon")
	var_5_0.goBrightIcon = gohelper.findChild(arg_5_1, "bright_icon")
	var_5_0.goEffect = gohelper.findChild(arg_5_1, "effect")
	var_5_0.goEffectOne = gohelper.findChild(arg_5_1, "effect/one")
	var_5_0.goEffectAll = gohelper.findChild(arg_5_1, "effect/all")

	return var_5_0
end

function var_0_0.loadImage(arg_6_0)
	local var_6_0 = arg_6_0:getCardConfig()

	arg_6_0.simageIcon:LoadImage(ResUrl.getSeasonCelebrityCard(var_6_0.icon))

	if not string.nilorempty(var_6_0.signIcon) then
		arg_6_0.simageSignature:LoadImage(ResUrl.getSignature(var_6_0.signIcon, "characterget"))
	end
end

function var_0_0.getCardConfig(arg_7_0)
	return SeasonConfig.instance:getSeasonEquipCo(arg_7_0:getCardId())
end

function var_0_0.getCardId(arg_8_0)
	return 11549
end

function var_0_0.onIndicatorChange(arg_9_0)
	if not arg_9_0.loadDone then
		return
	end

	local var_9_0 = FightDataHelper.fieldMgr:getIndicatorNum(arg_9_0.indicatorId)

	if var_9_0 <= 0 or var_9_0 > arg_9_0.totalIndicatorNum then
		return
	end

	arg_9_0.indicatorNum = var_9_0

	arg_9_0:playEffect()
end

function var_0_0.playEffect(arg_10_0)
	gohelper.setActive(arg_10_0.goIndicatorContainer, true)
	arg_10_0:resetEffect()
	arg_10_0:refreshDotItemNode()

	if arg_10_0.indicatorNum == arg_10_0.totalIndicatorNum then
		AudioMgr.instance:trigger(AudioEnum.UI.play_buff_accrued_number_2)
		gohelper.setActive(arg_10_0.goDownAll, true)
		gohelper.setActive(arg_10_0.goUpAll, true)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_buff_accrued_number_1)
		gohelper.setActive(arg_10_0.goDownOne, true)
		gohelper.setActive(arg_10_0.goUpOne, true)
	end

	TaskDispatcher.runDelay(arg_10_0.playEffectDone, arg_10_0, var_0_0.EffectDuration)

	local var_10_0 = arg_10_0.goDotItemList[arg_10_0.indicatorNum]

	if var_10_0 then
		gohelper.setActive(var_10_0.goEffect, true)

		local var_10_1 = arg_10_0.indicatorNum == arg_10_0.totalIndicatorNum

		gohelper.setActive(var_10_0.goEffectOne, not var_10_1)
		gohelper.setActive(var_10_0.goEffectAll, var_10_1)
	end
end

function var_0_0.refreshDotItemNode(arg_11_0)
	local var_11_0

	for iter_11_0 = 1, arg_11_0.totalIndicatorNum do
		local var_11_1 = arg_11_0.goDotItemList[iter_11_0]

		gohelper.setActive(var_11_1.goEffectOne, false)
		gohelper.setActive(var_11_1.goEffectAll, false)
		gohelper.setActive(var_11_1.goBrightIcon, iter_11_0 <= arg_11_0.indicatorNum)
		gohelper.setActive(var_11_1.goDarkIcon, iter_11_0 > arg_11_0.indicatorNum)
	end
end

function var_0_0.playEffectDone(arg_12_0)
	gohelper.setActive(arg_12_0.goIndicatorContainer, false)
	arg_12_0:resetEffect()
end

function var_0_0.resetEffect(arg_13_0)
	gohelper.setActive(arg_13_0.goDownOne, false)
	gohelper.setActive(arg_13_0.goDownAll, false)
	gohelper.setActive(arg_13_0.goUpOne, false)
	gohelper.setActive(arg_13_0.goUpAll, false)
end

function var_0_0.onDestroy(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.playEffectDone, arg_14_0)

	arg_14_0.goDotItemList = nil

	if arg_14_0.loader then
		arg_14_0.loader:onDestroy()

		arg_14_0.loader = nil
	end

	if gohelper.isNil(arg_14_0.simageIcon) then
		arg_14_0.simageIcon:UnLoadImage()
	end

	if gohelper.isNil(arg_14_0.simageSignature) then
		arg_14_0.simageSignature:UnLoadImage()
	end

	var_0_0.super.onDestroy(arg_14_0)
end

return var_0_0
