module("modules.logic.versionactivity1_2.jiexika.view.Activity114EventSelectItem", package.seeall)

slot0 = class("Activity114EventSelectItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._parent = slot1.parent
	slot0._index = slot1.index
	slot0._go = nil
	slot0._isSelect = nil
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_click")
	slot0._goselect = gohelper.findChild(slot1, "#go_selected")
	slot0._btnSelect = gohelper.findChildButtonWithAudio(slot1, "#go_selected/#btn_select")
	slot0._goselectonce = gohelper.findChild(slot1, "#go_selected/#go_once")
	slot0._txtselectoncedesc = gohelper.findChildTextMesh(slot1, "#go_selected/#go_once/#txt_desc")
	slot0._txtselectdesc = gohelper.findChildTextMesh(slot1, "#go_selected/#txt_desc")
	slot0._goselectcheck = gohelper.findChild(slot1, "#go_selected/#go_check")
	slot0._txtselectneed = gohelper.findChildTextMesh(slot1, "#go_selected/#go_check/#txt_need")
	slot0._txtselectrate = gohelper.findChildTextMesh(slot1, "#go_selected/#go_check/#txt_rate")
	slot0._btnselecthelp = gohelper.findChildButtonWithAudio(slot1, "#go_selected/#go_check/#btn_help")
	slot0._goselecttippos = gohelper.findChildComponent(slot1, "#go_selected/#go_tippos", typeof(UnityEngine.Transform))
	slot0._gounselect = gohelper.findChild(slot1, "#go_unselected")
	slot0._txtunselectdesc = gohelper.findChildTextMesh(slot1, "#go_unselected/#txt_desc")
	slot0._gounselectcheck = gohelper.findChild(slot1, "#go_unselected/#go_check")
	slot0._txtunselectneed = gohelper.findChildTextMesh(slot1, "#go_unselected/#go_check/#txt_need")
	slot0._txtunselectrate = gohelper.findChildTextMesh(slot1, "#go_unselected/#go_check/#txt_rate")
	slot0._btnunselecthelp = gohelper.findChildButtonWithAudio(slot1, "#go_unselected/#go_check/#btn_help")
	slot0._gounselecttippos = gohelper.findChildComponent(slot1, "#go_unselected/#go_tippos", typeof(UnityEngine.Transform))
	slot0._goSelectAnim = SLFramework.AnimatorPlayer.Get(slot0._goselect)
	slot5 = typeof
	slot0._goUnSelectAnim = slot0._gounselect:GetComponent(slot5(UnityEngine.Animator))
	slot0._isFirstEnter = true
	slot0.selectTypeTab = {}

	for slot5 = 1, 5 do
		slot0.selectTypeTab[slot5] = gohelper.findChild(slot0._btnSelect.gameObject, "go_type" .. slot5)
	end

	slot0:setSelect(false)
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0.setSelect, slot0, true)
	slot0._btnSelect:AddClickListener(slot0.selectChoice, slot0)
	slot0._btnselecthelp:AddClickListener(slot0.showHelp, slot0, slot0._goselecttippos)
	slot0._btnunselecthelp:AddClickListener(slot0.showHelp, slot0, slot0._gounselecttippos)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0._btnSelect:RemoveClickListener()
	slot0._btnselecthelp:RemoveClickListener()
	slot0._btnunselecthelp:RemoveClickListener()
end

function slot0.showHelp(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
	slot0._parent:showTips(slot0._data, slot1.position)
end

function slot0.setSelect(slot0, slot1)
	if slot1 == slot0._isSelect then
		return
	end

	slot0._isSelect = slot1

	if slot0._isFirstEnter then
		gohelper.setActive(slot0._goselect, false)
		gohelper.setActive(slot0._gounselect, true)

		slot0._isFirstEnter = false
	elseif slot1 then
		slot0._parent:onSelectIndex(slot0._index)
		gohelper.setActive(slot0._goselect, true)
		gohelper.setActive(slot0._gounselect, false)

		slot0._goselect:GetComponent(typeof(UnityEngine.Animator)).enabled = true
	else
		slot0._goSelectAnim:Stop()
		slot0._goSelectAnim:Play(UIAnimationName.Close, slot0.playUnSelectAnimFinish, slot0)
	end
end

function slot0.playUnSelectAnimFinish(slot0)
	gohelper.setActive(slot0._goselect, false)
	gohelper.setActive(slot0._gounselect, true)
	slot0._goUnSelectAnim:Play(UIAnimationName.Switch, 0, 0)
end

function slot0.updateData(slot0, slot1, slot2, slot3, slot4)
	slot0._data = slot2
	slot0._selectCb = slot3
	slot0._selectCbObj = slot4

	gohelper.setActive(slot0._goselectonce, slot1 == Activity114Enum.EventContentType.Check_Once)
	gohelper.setActive(slot0._goselectcheck, slot1 ~= Activity114Enum.EventContentType.Normal)
	gohelper.setActive(slot0._gounselectcheck, slot1 ~= Activity114Enum.EventContentType.Normal)
	gohelper.setActive(slot0._txtselectdesc, slot1 ~= Activity114Enum.EventContentType.Check_Once)
	recthelper.setWidth(slot0._txtunselectdesc.transform, slot1 == Activity114Enum.EventContentType.Check_Once and 380 or 500)
	recthelper.setWidth(slot0._txtselectdesc.transform, slot1 == Activity114Enum.EventContentType.Check_Once and 460 or 700)

	slot5 = 5

	if slot1 == Activity114Enum.EventContentType.Normal then
		slot0._txtselectdesc.text = slot2
		slot0._txtunselectdesc.text = slot2
	else
		if slot1 == Activity114Enum.EventContentType.Check then
			slot0._txtselectdesc.text = slot2.desc
		else
			slot0._txtselectoncedesc.text = slot2.desc
		end

		slot0._txtunselectdesc.text = slot2.desc
		slot5 = slot2.level
		slot0._txtselectrate.text = slot2.rateDes
		slot0._txtunselectrate.text = slot2.rateDes
		slot0._txtselectneed.text = slot2.realVerify
		slot0._txtunselectneed.text = slot2.realVerify

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtselectneed, slot2.threshold ~= slot2.realVerify and "#E19C60" or "#FFFFFF")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtunselectneed, slot2.threshold ~= slot2.realVerify and "#E19C60" or "#FFFFFF")
	end

	for slot9 = 1, 5 do
		gohelper.setActive(slot0.selectTypeTab[slot9], slot9 == slot5)
	end
end

function slot0.selectChoice(slot0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

	slot0._isFirstEnter = true

	slot0._selectCb(slot0._selectCbObj, slot0._index)
end

function slot0.destory(slot0)
	gohelper.destroy(slot0._go)
end

function slot0.onDestroy(slot0)
	slot0._go = nil
end

return slot0
