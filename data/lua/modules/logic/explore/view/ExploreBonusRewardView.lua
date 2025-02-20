module("modules.logic.explore.view.ExploreBonusRewardView", package.seeall)

slot0 = class("ExploreBonusRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gobtnsitem = gohelper.findChild(slot0.viewGO, "#go_btns/#btn_level")
	slot0._txtnum = gohelper.findChildTextMesh(slot0.viewGO, "top/title/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0.closeThis, slot0)
	slot0._btnclose2:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)

	slot1 = slot0.viewParam
	slot2 = DungeonConfig.instance:getChapterEpisodeCOList(slot1.id)
	slot0._episodeCoList = slot2
	slot0._btns = {}

	gohelper.CreateObjList(slot0, slot0.createItem, slot2, slot0._gobtns, slot0._gobtnsitem)

	slot3, slot4, slot5, slot6, slot7, slot8 = ExploreSimpleModel.instance:getChapterCoinCount(slot1.id)
	slot0._txtnum.text = string.format("<color=#f68736>%d</color>/%d", slot3, slot6)

	slot0:onClickLevel(1)
end

function slot0.createItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMesh(slot1, "#txt_name")
	slot4.text = slot2.name

	slot0:addClickCb(gohelper.findButtonWithAudio(slot1), slot0.onClickLevel, slot0, slot3)

	slot0._btns[slot3] = {
		slot4,
		gohelper.findChildImage(slot1, ""),
		gohelper.findChild(slot1, "#select_btn")
	}
end

function slot0.onClickLevel(slot0, slot1)
	slot6 = ExploreConfig.instance
	slot6 = slot6.getRewardConfig

	ExploreTaskModel.instance:getTaskList(0):setList(slot6(slot6, slot0.viewParam.id, slot0._episodeCoList[slot1].id))

	for slot6 = 1, #slot0._btns do
		ZProj.UGUIHelper.SetColorAlpha(slot0._btns[slot6][1], slot6 == slot1 and 1 or 0.5)
		ZProj.UGUIHelper.SetColorAlpha(slot0._btns[slot6][2], slot6 == slot1 and 1 or 0.3)
		gohelper.setActive(slot0._btns[slot6][3], slot6 == slot1)
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
