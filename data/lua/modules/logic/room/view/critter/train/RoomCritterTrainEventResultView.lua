module("modules.logic.room.view.critter.train.RoomCritterTrainEventResultView", package.seeall)

slot0 = class("RoomCritterTrainEventResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._golefttopbtns = gohelper.findChild(slot0.viewGO, "#go_lefttopbtns")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spine")
	slot0._goexittips = gohelper.findChild(slot0.viewGO, "#go_exittips")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "#go_attribute")
	slot0._goattributeup = gohelper.findChild(slot0.viewGO, "#go_attributeup")
	slot0._txtup = gohelper.findChildText(slot0.viewGO, "#go_attributeup/attributeup/up/#txt_up")
	slot0._goattributeupitem = gohelper.findChild(slot0.viewGO, "#go_attributeup/attributeup")
	slot0._goattributeupeffect = gohelper.findChild(slot0.viewGO, "#attributeup_effect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._onCloseFullView(slot0, slot1)
	gohelper.setActive(GameSceneMgr.instance:getScene(SceneType.Room):getSceneContainerGO(), true)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
end

function slot0._addEvents(slot0)
	slot0._exitBtn:AddClickListener(slot0._onExitClick, slot0)
end

function slot0._removeEvents(slot0)
	slot0._exitBtn:RemoveClickListener()
end

function slot0._onExitClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._selectItems = {}
	slot0._optionId = 1
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._attributeItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(RoomCritterTrainDetailItem.prefabPath, slot0._goattribute), RoomCritterTrainDetailItem, slot0)
	slot0._exitBtn = gohelper.getClick(slot0._goexittips)

	slot0:_addEvents()
	gohelper.setActive(slot0._goattribute, false)
	gohelper.setActive(slot0._goconversation, false)
	gohelper.setActive(slot0._goexittips, false)
	gohelper.setActive(slot0._goattributeup, false)
	gohelper.setActive(slot0._goattributeupitem, false)
end

function slot0._startShowResult(slot0, slot1)
	gohelper.setActive(slot0._goexittips, true)
	gohelper.setActive(slot0._goattributeup, true)
	gohelper.setActive(slot0._goattribute, true)
	gohelper.setActive(slot0._goattributeupeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_peixun)
	slot0._viewAnim:Play("open", 0, 0)

	slot0._attributeMOs = slot1

	slot0._attributeItem:playLevelUp(slot1, true)

	slot0._repeatCount = 0

	TaskDispatcher.runRepeat(slot0._showAttribute, slot0, 0.3, #slot1)
end

function slot0._showAttribute(slot0)
	slot0._repeatCount = slot0._repeatCount + 1

	if not slot0._attributeMOs or slot0._repeatCount > #slot0._attributeMOs then
		return
	end

	slot2 = gohelper.clone(slot0._goattributeupitem)

	gohelper.addChild(gohelper.findChild(slot0._goattributeup, tostring(slot0._repeatCount)), slot2)
	gohelper.setActive(slot2, true)

	slot4 = slot0._attributeMOs[slot0._repeatCount]
	gohelper.findChildText(slot2, "up/#txt_up").text = string.format("%s + %s", CritterConfig.instance:getCritterAttributeCfg(slot4.attributeId).name, slot4.value)
end

function slot0.onOpen(slot0)
	slot0._critterMO = slot0.viewParam.critterMO
	slot0._addAttributeMOs = slot0.viewParam.addAttributeMOs

	slot0._attributeItem:onUpdateMO(slot0._critterMO)
	slot0:_startShowResult(slot0._addAttributeMOs)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._showAttribute, slot0)

	if slot0._selectItems then
		for slot4, slot5 in pairs(slot0._selectItems) do
			slot5:destroy()
		end

		slot0._selectItems = nil
	end

	slot0._attributeItem:onDestroy()
end

return slot0
