module("modules.logic.room.view.critter.train.RoomCritterTrainEventResultView", package.seeall)

local var_0_0 = class("RoomCritterTrainEventResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golefttopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_lefttopbtns")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")
	arg_1_0._goexittips = gohelper.findChild(arg_1_0.viewGO, "#go_exittips")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "#go_attribute")
	arg_1_0._goattributeup = gohelper.findChild(arg_1_0.viewGO, "#go_attributeup")
	arg_1_0._txtup = gohelper.findChildText(arg_1_0.viewGO, "#go_attributeup/attributeup/up/#txt_up")
	arg_1_0._goattributeupitem = gohelper.findChild(arg_1_0.viewGO, "#go_attributeup/attributeup")
	arg_1_0._goattributeupeffect = gohelper.findChild(arg_1_0.viewGO, "#attributeup_effect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onCloseFullView(arg_4_0, arg_4_1)
	local var_4_0 = GameSceneMgr.instance:getScene(SceneType.Room):getSceneContainerGO()

	gohelper.setActive(var_4_0, true)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_4_0._onCloseFullView, arg_4_0)
end

function var_0_0._addEvents(arg_5_0)
	arg_5_0._exitBtn:AddClickListener(arg_5_0._onExitClick, arg_5_0)
end

function var_0_0._removeEvents(arg_6_0)
	arg_6_0._exitBtn:RemoveClickListener()
end

function var_0_0._onExitClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._selectItems = {}
	arg_8_0._optionId = 1
	arg_8_0._viewAnim = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_8_0 = arg_8_0:getResInst(RoomCritterTrainDetailItem.prefabPath, arg_8_0._goattribute)

	arg_8_0._attributeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_0, RoomCritterTrainDetailItem, arg_8_0)
	arg_8_0._exitBtn = gohelper.getClick(arg_8_0._goexittips)

	arg_8_0:_addEvents()
	gohelper.setActive(arg_8_0._goattribute, false)
	gohelper.setActive(arg_8_0._goconversation, false)
	gohelper.setActive(arg_8_0._goexittips, false)
	gohelper.setActive(arg_8_0._goattributeup, false)
	gohelper.setActive(arg_8_0._goattributeupitem, false)
end

function var_0_0._startShowResult(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goexittips, true)
	gohelper.setActive(arg_9_0._goattributeup, true)
	gohelper.setActive(arg_9_0._goattribute, true)
	gohelper.setActive(arg_9_0._goattributeupeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_peixun)
	arg_9_0._viewAnim:Play("open", 0, 0)

	arg_9_0._attributeMOs = arg_9_1

	arg_9_0._attributeItem:playLevelUp(arg_9_1, true)

	arg_9_0._repeatCount = 0

	TaskDispatcher.runRepeat(arg_9_0._showAttribute, arg_9_0, 0.3, #arg_9_1)
end

function var_0_0._showAttribute(arg_10_0)
	arg_10_0._repeatCount = arg_10_0._repeatCount + 1

	if not arg_10_0._attributeMOs or arg_10_0._repeatCount > #arg_10_0._attributeMOs then
		return
	end

	local var_10_0 = gohelper.findChild(arg_10_0._goattributeup, tostring(arg_10_0._repeatCount))
	local var_10_1 = gohelper.clone(arg_10_0._goattributeupitem)

	gohelper.addChild(var_10_0, var_10_1)
	gohelper.setActive(var_10_1, true)

	local var_10_2 = gohelper.findChildText(var_10_1, "up/#txt_up")
	local var_10_3 = arg_10_0._attributeMOs[arg_10_0._repeatCount]
	local var_10_4 = CritterConfig.instance:getCritterAttributeCfg(var_10_3.attributeId).name
	local var_10_5 = var_10_3.value

	var_10_2.text = string.format("%s + %s", var_10_4, var_10_5)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._critterMO = arg_11_0.viewParam.critterMO
	arg_11_0._addAttributeMOs = arg_11_0.viewParam.addAttributeMOs

	arg_11_0._attributeItem:onUpdateMO(arg_11_0._critterMO)
	arg_11_0:_startShowResult(arg_11_0._addAttributeMOs)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_13_0._showAttribute, arg_13_0)

	if arg_13_0._selectItems then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._selectItems) do
			iter_13_1:destroy()
		end

		arg_13_0._selectItems = nil
	end

	arg_13_0._attributeItem:onDestroy()
end

return var_0_0
