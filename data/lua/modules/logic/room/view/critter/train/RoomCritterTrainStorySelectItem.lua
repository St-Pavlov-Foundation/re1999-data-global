module("modules.logic.room.view.critter.train.RoomCritterTrainStorySelectItem", package.seeall)

local var_0_0 = class("RoomCritterTrainStorySelectItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = gohelper.cloneInPlace(arg_1_1, string.format("selectItem%s", arg_1_2))

	gohelper.setActive(arg_1_0.go, false)

	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.go, "btnselect")
	arg_1_0._goselectlight = gohelper.findChild(arg_1_0.go, "btnselect/light")
	arg_1_0._gobgdark = gohelper.findChild(arg_1_0.go, "bgdark")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.go, "bgdark/icon")
	arg_1_0._txtcontentdark = gohelper.findChildText(arg_1_0.go, "bgdark/txtcontentdark")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.go, "bgdark/#txt_num")
	arg_1_0._golvup = gohelper.findChild(arg_1_0.go, "go_lvup")
	arg_1_0._txtlvup = gohelper.findChildText(arg_1_0.go, "go_lvup/txt_lvup")
	arg_1_0._goup = gohelper.findChild(arg_1_0.go, "go_up")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.go, "go_num")
	arg_1_0._txtcountnum = gohelper.findChildText(arg_1_0.go, "go_num/#txt_num")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.go, "btncancel")
	arg_1_0._goselecteff = gohelper.findChild(arg_1_0.go, "#selecteff")

	gohelper.setActive(arg_1_0._golvup, false)
	gohelper.setActive(arg_1_0._goselecteff, false)
	arg_1_0:_addEvents()
end

function var_0_0._addEvents(arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._btnselectOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
end

function var_0_0._removeEvents(arg_3_0)
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
end

function var_0_0.show(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._optionId = arg_4_1
	arg_4_0._count = arg_4_4
	arg_4_0._attributeMO = arg_4_2.trainInfo:getEventOptionMOByOptionId(arg_4_3, arg_4_1).addAttriButes[1]
	arg_4_0._attributeInfo = arg_4_2:getAttributeInfoByType(arg_4_0._attributeMO.attributeId)
	arg_4_0._addAttributeValue = arg_4_2.trainInfo:getAddAttributeValue(arg_4_0._attributeMO.attributeId)
	arg_4_0._attributeCo = CritterConfig.instance:getCritterAttributeCfg(arg_4_0._attributeMO.attributeId)
	arg_4_0._critterMo = arg_4_2
	arg_4_0._eventId = arg_4_3

	arg_4_0:_refreshItem()
end

function var_0_0._btncancelOnClick(arg_5_0)
	if RoomTrainCritterModel.instance:getSelectOptionCount(arg_5_0._optionId) <= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.CritterTrainAttributeCancel, arg_5_0._attributeCo.id, arg_5_0._optionId)
end

function var_0_0._btnselectOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._goselecteff, false)
	TaskDispatcher.cancelTask(arg_6_0._playSelectFinished, arg_6_0)

	if RoomTrainCritterModel.instance:getSelectOptionLimitCount() <= 0 then
		return
	end

	if arg_6_0._count and arg_6_0._count < 1 then
		gohelper.setActive(arg_6_0._goselecteff, true)
		TaskDispatcher.runDelay(arg_6_0._playSelectFinished, arg_6_0, 0.34)
	end

	RoomController.instance:dispatchEvent(RoomEvent.CritterTrainAttributeSelected, arg_6_0._attributeCo.id, arg_6_0._optionId)
end

function var_0_0._playSelectFinished(arg_7_0)
	gohelper.setActive(arg_7_0._goselecteff, false)
end

function var_0_0._refreshItem(arg_8_0)
	gohelper.setActive(arg_8_0._goselectlight, arg_8_0._count and arg_8_0._count > 0)
	gohelper.setActive(arg_8_0._btncancel.gameObject, arg_8_0._count and arg_8_0._count > 0)
	ZProj.TweenHelper.KillByObj(arg_8_0.go)

	if not arg_8_0.go.activeSelf then
		gohelper.setActive(arg_8_0.go, true)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_8_0.go, 0, 1, 0.6)
	end

	arg_8_0._txtcontentdark.text = arg_8_0._attributeCo.name

	UISpriteSetMgr.instance:setCritterSprite(arg_8_0._imageicon, arg_8_0._attributeCo.icon)

	arg_8_0._txtnum.text = string.format("+%.02f", arg_8_0._attributeMO.value)

	gohelper.setActive(arg_8_0._gonum, arg_8_0._count and arg_8_0._count > 0)

	arg_8_0._txtcountnum.text = arg_8_0._count or 0

	local var_8_0 = false

	if CritterConfig.instance:getCritterHeroPreferenceCfg(arg_8_0._critterMo.trainInfo.heroId).effectAttribute == arg_8_0._attributeMO.attributeId then
		var_8_0 = true
	end

	gohelper.setActive(arg_8_0._goup, var_8_0)

	local var_8_1 = arg_8_0._attributeInfo.value + arg_8_0._addAttributeValue
	local var_8_2 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(var_8_1).level
	local var_8_3 = RoomTrainCritterModel.instance:getSelectOptionCount(arg_8_0._optionId)
	local var_8_4 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(var_8_3 * arg_8_0._attributeMO.value + var_8_1).level

	if var_8_2 == CritterConfig.instance:getMaxCritterAttributeLevelCfg().level then
		arg_8_0._txtnum.text = string.format("+%.02f(MAX)", arg_8_0._attributeMO.value)
	end

	gohelper.setActive(arg_8_0._golvup, var_8_2 < var_8_4)
end

function var_0_0.destroy(arg_9_0)
	arg_9_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_9_0._playSelectFinished, arg_9_0)
	ZProj.TweenHelper.KillByObj(arg_9_0.go)
end

return var_0_0
