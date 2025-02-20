module("modules.logic.explore.view.ExploreBonusSceneView", package.seeall)

slot0 = class("ExploreBonusSceneView", BaseView)

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember(slot0, "_hasIconDialogItem")
	GameUtil.onDestroyViewMemberList(slot0, "_tmpMarkTopTextList")
end

function slot0._editableInitView(slot0)
	slot0._tmpMarkTopTextList = {}
end

function slot0.onInitView(slot0)
	slot0._btnfullscreen = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fullscreen")
	slot0._gochoicelist = gohelper.findChild(slot0.viewGO, "#go_choicelist")
	slot0._gochoiceitem = gohelper.findChild(slot0.viewGO, "#go_choicelist/#go_choiceitem")
	slot0._txttalkinfo = gohelper.findChildText(slot0.viewGO, "#txt_talkinfo")
	slot0._txttalker = gohelper.findChildText(slot0.viewGO, "#txt_talker")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	NavigateMgr.instance:addSpace(ViewName.ExploreBonusSceneView, slot0.onClickFull, slot0)
	slot0._btnfullscreen:AddClickListener(slot0.onClickFull, slot0)
end

function slot0.removeEvents(slot0)
	NavigateMgr.instance:removeSpace(ViewName.ExploreBonusSceneView)
	slot0._btnfullscreen:RemoveClickListener()
end

function slot0.onClickFull(slot0)
	if slot0._hasIconDialogItem and slot0._hasIconDialogItem:isPlaying() then
		slot0._hasIconDialogItem:conFinished()

		return
	end

	if not slot0._btnDatas[1] then
		slot0._curStep = slot0._curStep + 1

		if slot0.config[slot0._curStep] then
			table.insert(slot0.options, -1)
			slot0:onStep()
		else
			if slot0.viewParam.callBack then
				slot0.viewParam.callBack(slot0.viewParam.callBackObj, slot0.options)
			end

			slot0:closeThis()
		end
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	slot0.unit = slot0.viewParam.unit
	slot0.config = ExploreConfig.instance:getDialogueConfig(slot0.viewParam.id)

	if not slot0.config then
		logError("对话配置不存在，id：" .. tostring(slot0.viewParam.id))
		slot0:closeThis()

		return
	end

	slot0.options = {}
	slot0._curStep = 1

	slot0:onStep()
end

function slot0.onStep(slot0)
	slot2 = string.gsub(slot0.config[slot0._curStep].desc, " ", " ")

	if LangSettings.instance:isEn() then
		slot2 = slot1.desc
	end

	if not slot0._hasIconDialogItem then
		slot0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(slot0.viewGO, TMPFadeIn)

		slot0._hasIconDialogItem:setTopOffset(0, -2.4)
		slot0._hasIconDialogItem:setLineSpacing(26)
	end

	slot0._hasIconDialogItem:playNormalText(slot2)

	slot0._txttalker.text = slot1.speaker
	slot3 = {}

	if not string.nilorempty(slot1.bonusButton) then
		slot3 = string.split(slot1.bonusButton, "|")
	end

	gohelper.CreateObjList(slot0, slot0._createItem, slot3, slot0._gochoicelist, slot0._gochoiceitem)

	slot0._btnDatas = slot3
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	if not slot0._tmpMarkTopTextList[slot3] then
		slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChildText(slot1, "info").gameObject, TMPMarkTopText)

		slot5:setTopOffset(0, -2.6)
		slot5:setLineSpacing(5)

		slot0._tmpMarkTopTextList[slot3] = slot5
	else
		slot5:reInitByCmp(slot4)
	end

	slot5:setData(slot2)

	slot6 = gohelper.findChildButtonWithAudio(slot1, "click")

	slot0:removeClickCb(slot6)
	slot0:addClickCb(slot6, slot0.onBtnClick, slot0, slot3)
end

function slot0.onBtnClick(slot0, slot1)
	table.insert(slot0.options, slot1)

	slot2 = slot0.config[slot0._curStep]

	GameSceneMgr.instance:getCurScene().stat:onTriggerEggs(string.format("%d_%d", slot2.id, slot2.stepid), slot0._btnDatas[slot1])

	slot0._btnDatas = {}

	slot0:onClickFull()
end

return slot0
