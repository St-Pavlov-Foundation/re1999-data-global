module("modules.logic.room.view.critter.RoomCritterTrainDetailItemAttributeItem", package.seeall)

local var_0_0 = class("RoomCritterTrainDetailItemAttributeItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = gohelper.cloneInPlace(arg_1_1)

	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.go, "#image_icon")
	arg_1_0._goiconup = gohelper.findChild(arg_1_0.go, "#txt_name/iconup")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.go, "#txt_name")
	arg_1_0._goratelevel = gohelper.findChild(arg_1_0.go, "go_ratelevel")
	arg_1_0._txtratelevel = gohelper.findChildText(arg_1_0.go, "go_ratelevel/#txt_level")
	arg_1_0._imagelvprogress = gohelper.findChildImage(arg_1_0.go, "go_ratelevel/ProgressBg/#simage_levelBarValue")
	arg_1_0._imagelvbar = gohelper.findChildImage(arg_1_0.go, "go_ratelevel/ProgressBg/#bar_add")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.go, "go_detail")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.go, "go_detail/#txt_num")
	arg_1_0._imagedetailprogress = gohelper.findChildImage(arg_1_0.go, "go_detail/ProgressBg/#simage_totalBarValue")
	arg_1_0._imagedetailbar = gohelper.findChildImage(arg_1_0.go, "go_detail/ProgressBg/#bar_add")
	arg_1_0._imagelvbar.fillAmount = 0
	arg_1_0._imagedetailbar.fillAmount = 0

	arg_1_0:_addEvents()
end

function var_0_0._addEvents(arg_2_0)
	return
end

function var_0_0._removeEvents(arg_3_0)
	return
end

function var_0_0.hideItem(arg_4_0)
	gohelper.setActive(arg_4_0.go, true)
end

function var_0_0.getAttributeId(arg_5_0)
	return arg_5_0._attributeMO.attributeId
end

function var_0_0.setShowLv(arg_6_0, arg_6_1)
	arg_6_0._showLv = arg_6_1
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._attributeMO = arg_7_1
	arg_7_0._critterMO = arg_7_2

	local var_7_0 = 0

	if arg_7_0._attributeMO.attributeId == CritterEnum.AttributeType.Efficiency then
		var_7_0 = arg_7_0._critterMO.efficiency
	elseif arg_7_0._attributeMO.attributeId == CritterEnum.AttributeType.Patience then
		var_7_0 = arg_7_0._critterMO.patience
	elseif arg_7_0._attributeMO.attributeId == CritterEnum.AttributeType.Lucky then
		var_7_0 = arg_7_0._critterMO.lucky
	end

	arg_7_0._attributeBaseValue = var_7_0 + arg_7_0._critterMO.trainInfo:getAddAttributeValue(arg_7_0._attributeMO.attributeId)
	arg_7_0._trainHeroMO = arg_7_2 and RoomTrainHeroListModel.instance:getById(arg_7_2.trainInfo.heroId)
	arg_7_0._heroAddIncrRate = 0

	if arg_7_0._trainHeroMO and arg_7_0._trainHeroMO:chcekPrefernectCritterId(arg_7_0._critterMO:getDefineId()) then
		local var_7_1 = arg_7_0._trainHeroMO.critterHeroConfig

		if var_7_1 and arg_7_1 and arg_7_1.attributeId == var_7_1.effectAttribute then
			arg_7_0._heroAddIncrRate = var_7_1.addIncrRate
		end
	end

	gohelper.setActive(arg_7_0.go, true)
	arg_7_0:refreshUI()
end

local var_0_1 = {
	"#5D8FB3",
	"#6A4B8E",
	"#BAA64D",
	"#BA7841",
	"#E57A3A"
}

function var_0_0.refreshUI(arg_8_0)
	gohelper.setActive(arg_8_0._godetail, not arg_8_0._showLv)
	gohelper.setActive(arg_8_0._goratelevel, arg_8_0._showLv)

	if not arg_8_0._attributeMO then
		return
	end

	local var_8_0 = arg_8_0._critterMO:getAddValuePerHourByType(arg_8_0._attributeMO.attributeId)
	local var_8_1 = math.min(arg_8_0._attributeBaseValue, CritterConfig.instance:getCritterAttributeMax())

	if arg_8_0._attributeMO:getIsAddition() or arg_8_0._heroAddIncrRate > 0 then
		arg_8_0._txtnum.text = string.format("%d<color=#65B96F>(+%.02f/h)</color>", math.floor(var_8_1), var_8_0)
	else
		arg_8_0._txtnum.text = string.format("%d(+%.02f/h)", math.floor(var_8_1), var_8_0)
	end

	local var_8_2 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(arg_8_0._attributeBaseValue)
	local var_8_3 = CritterConfig.instance:getCritterAttributeLevelCfg(var_8_2.level + 1)
	local var_8_4 = var_8_3 and (arg_8_0._attributeBaseValue - var_8_2.minValue) / (var_8_3.minValue - var_8_2.minValue) or 1

	arg_8_0._imagedetailprogress.fillAmount = var_8_4

	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._imagedetailprogress, var_0_1[var_8_2.level])
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._imagedetailbar, var_0_1[var_8_2.level])

	arg_8_0._txtratelevel.text = var_8_2.name
	arg_8_0._imagelvprogress.fillAmount = var_8_4

	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._imagelvprogress, var_0_1[var_8_2.level])
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._imagelvbar, var_0_1[var_8_2.level])
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtratelevel, var_0_1[var_8_2.level])

	if arg_8_0._txtname then
		arg_8_0._txtname.text = arg_8_0._attributeMO:getName()
	end

	if arg_8_0._imageicon and not string.nilorempty(arg_8_0._attributeMO:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(arg_8_0._imageicon, arg_8_0._attributeMO:getIcon())
	end

	gohelper.setActive(arg_8_0._goiconup, arg_8_0._attributeMO:getIsAddition() or arg_8_0._heroAddIncrRate > 0)
end

function var_0_0.playNoLevelUp(arg_9_0)
	arg_9_0._addAttr = false

	local var_9_0 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(arg_9_0._attributeBaseValue)
	local var_9_1 = CritterConfig.instance:getCritterAttributeLevelCfg(var_9_0.level + 1)

	arg_9_0._startValue = var_9_1 and (arg_9_0._attributeBaseValue - var_9_0.minValue) / (var_9_1.minValue - var_9_0.minValue) or 1
	arg_9_0._endValue = arg_9_0._startValue

	local var_9_2 = math.min(arg_9_0._attributeBaseValue, CritterConfig.instance:getCritterAttributeMax())

	arg_9_0._txtnum.text = var_9_2

	TaskDispatcher.runDelay(arg_9_0._detailFinished, arg_9_0, 1.5)
end

function var_0_0.playBarAdd(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_0._imagelvbar.gameObject, arg_10_1)
	gohelper.setActive(arg_10_0._imagedetailbar.gameObject, arg_10_1)

	if arg_10_1 then
		arg_10_0._addAttributeMO = arg_10_2

		local var_10_0 = RoomTrainCritterModel.instance:getSelectOptionCount(arg_10_2.attributeId)
		local var_10_1 = arg_10_0._attributeBaseValue + var_10_0 * arg_10_0._addAttributeMO.value
		local var_10_2 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(arg_10_0._attributeBaseValue)
		local var_10_3 = CritterConfig.instance:getCritterAttributeLevelCfg(var_10_2.level + 1)
		local var_10_4 = var_10_3 and (var_10_1 - var_10_2.minValue) / (var_10_3.minValue - var_10_2.minValue) or 1

		arg_10_0._imagelvbar.fillAmount = var_10_4
		arg_10_0._imagedetailbar.fillAmount = var_10_4
	else
		arg_10_0._imagelvbar.fillAmount = 0
		arg_10_0._imagedetailbar.fillAmount = 0
	end
end

function var_0_0.playLevelUp(arg_11_0, arg_11_1, arg_11_2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("attributelevelup")
	TaskDispatcher.cancelTask(arg_11_0._detailFinished, arg_11_0)

	arg_11_0._addAttributeMO = arg_11_1
	arg_11_0._addAttr = true
	arg_11_0._tweenEndAttrValue = arg_11_0._attributeBaseValue + arg_11_0._addAttributeMO.value
	arg_11_0._tweenStartAttrValue = arg_11_0._attributeBaseValue

	if arg_11_2 == true then
		arg_11_0._tweenEndAttrValue = arg_11_0._attributeBaseValue
		arg_11_0._tweenStartAttrValue = arg_11_0._attributeBaseValue - arg_11_0._addAttributeMO.value
		arg_11_0._addAttributeMO = nil
	end

	local var_11_0 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(arg_11_0._tweenStartAttrValue)
	local var_11_1 = CritterConfig.instance:getCritterAttributeLevelCfg(var_11_0.level + 1)

	arg_11_0._endValue = var_11_1 and (arg_11_0._tweenEndAttrValue - var_11_0.minValue) / (var_11_1.minValue - var_11_0.minValue) or 1
	arg_11_0._startValue = var_11_1 and (arg_11_0._tweenStartAttrValue - var_11_0.minValue) / (var_11_1.minValue - var_11_0.minValue) or 1

	arg_11_0:_clearTween()

	arg_11_0._fillDetailTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, arg_11_0._detailFillUpdate, arg_11_0._detailFinished, arg_11_0, nil, EaseType.Linear)
end

function var_0_0._detailFillUpdate(arg_12_0, arg_12_1)
	arg_12_0._imagedetailprogress.fillAmount = arg_12_0._startValue + arg_12_1 * (arg_12_0._endValue - arg_12_0._startValue)

	local var_12_0 = arg_12_0._tweenStartAttrValue + arg_12_1 * (arg_12_0._tweenEndAttrValue - arg_12_0._tweenStartAttrValue)
	local var_12_1 = math.min(var_12_0, CritterConfig.instance:getCritterAttributeMax())

	arg_12_0._txtnum.text = string.format("%.02f", var_12_1)
end

function var_0_0._detailFinished(arg_13_0)
	gohelper.setActive(arg_13_0._godetail, false)
	gohelper.setActive(arg_13_0._goratelevel, true)

	local var_13_0 = arg_13_0._addAttributeMO and arg_13_0._addAttributeMO.value or 0
	local var_13_1 = math.min(arg_13_0._attributeMO.value + var_13_0, CritterConfig.instance:getCritterAttributeMax())

	arg_13_0._txtnum.text = var_13_1

	arg_13_0:_clearTween()

	arg_13_0._fillLvTweenId = ZProj.TweenHelper.DOTweenFloat(arg_13_0._startValue, arg_13_0._endValue, 1.5, arg_13_0._lvFillUpdate, arg_13_0._lvFinished, arg_13_0, nil, EaseType.Linear)
end

function var_0_0._lvFillUpdate(arg_14_0, arg_14_1)
	arg_14_0._imagelvprogress.fillAmount = arg_14_1
end

function var_0_0._lvFinished(arg_15_0)
	UIBlockMgr.instance:endBlock("attributelevelup")

	if arg_15_0._addAttr then
		RoomController.instance:dispatchEvent(RoomEvent.CritterTrainLevelFinished)
	end
end

function var_0_0._clearTween(arg_16_0)
	if arg_16_0._fillDetailTweenId then
		ZProj.TweenHelper.KillById(arg_16_0._fillDetailTweenId)

		arg_16_0._fillDetailTweenId = nil
	end

	if arg_16_0._fillLvTweenId then
		ZProj.TweenHelper.KillById(arg_16_0._fillLvTweenId)

		arg_16_0._fillLvTweenId = nil
	end
end

function var_0_0.destroy(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._detailFinished, arg_17_0)
	arg_17_0:_removeEvents()
	arg_17_0:_clearTween()
end

return var_0_0
