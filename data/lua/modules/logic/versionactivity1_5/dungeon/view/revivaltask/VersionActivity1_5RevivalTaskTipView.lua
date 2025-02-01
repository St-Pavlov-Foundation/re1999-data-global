module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskTipView", package.seeall)

slot0 = class("VersionActivity1_5RevivalTaskTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotipscontainer = gohelper.findChild(slot0.viewGO, "#go_tipcontainer")
	slot0._goclosetip = gohelper.findChild(slot0.viewGO, "#go_tipcontainer/#go_closetip")
	slot0._txtTipTitle = gohelper.findChildText(slot0.viewGO, "#go_tipcontainer/#go_tips/#txt_title")
	slot0._simageTipPic = gohelper.findChildSingleImage(slot0.viewGO, "#go_tipcontainer/#go_tips/#simage_pic")
	slot0._txtTipDesc = gohelper.findChildText(slot0.viewGO, "#go_tipcontainer/#go_tips/#txt_desc")
	slot0._btnReplay = gohelper.findChildButton(slot0.viewGO, "#go_tipcontainer/#go_tips/#btn_replay")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnReplay:AddClickListener(slot0.onClickBtnReplay, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnReplay:RemoveClickListener()
end

function slot0.onClickBtnReplay(slot0)
	if not slot0.isShowBtn then
		return
	end

	if slot0.showType == DungeonEnum.ElementType.None then
		ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
			fragmentId = slot0.showParam
		})
	elseif slot0.showType == DungeonEnum.ElementType.EnterDialogue then
		DialogueController.instance:enterDialogue(slot0.showParam)
	else
		logError("un support type, " .. tostring(slot0.showType))
	end
end

function slot0.onClickCloseBtn(slot0)
	slot0.config = nil

	gohelper.setActive(slot0._gotipscontainer, false)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gotipscontainer, false)

	slot0.closeClick = gohelper.getClickWithDefaultAudio(slot0._goclosetip)

	slot0.closeClick:AddClickListener(slot0.onClickCloseBtn, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ShowSubTaskDetail, slot0.showSubTaskDetail, slot0)
end

function slot0.showSubTaskDetail(slot0, slot1)
	slot0.config = slot1

	gohelper.setActive(slot0._gotipscontainer, true)

	slot0._txtTipTitle.text = slot0.config.title

	if LangSettings.instance:isEn() then
		slot0._txtTipDesc.text = slot0.config.desc .. " " .. slot0.config.descSuffix
	else
		slot0._txtTipDesc.text = slot0.config.desc .. slot0.config.descSuffix
	end

	slot0._simageTipPic:LoadImage(ResUrl.getV1a5RevivalTaskSingleBg(slot0.config.image))
	slot0:showReplayBtn()
end

function slot0.showReplayBtn(slot0)
	slot0.isShowBtn = false

	if lua_chapter_map_element.configDict[slot0.config.elementList[1]].type == DungeonEnum.ElementType.None then
		if slot2.fragment ~= 0 then
			slot0.isShowBtn = true
			slot0.showType = DungeonEnum.ElementType.None
			slot0.showParam = slot2.fragment
		end
	elseif slot2.type == DungeonEnum.ElementType.EnterDialogue then
		slot0.isShowBtn = true
		slot0.showType = DungeonEnum.ElementType.EnterDialogue
		slot0.showParam = tonumber(slot2.param)
	end

	gohelper.setActive(slot0._btnReplay, slot0.isShowBtn)
end

function slot0.onDestroyView(slot0)
	slot0._simageTipPic:UnLoadImage()
	slot0.closeClick:RemoveClickListener()
end

return slot0
