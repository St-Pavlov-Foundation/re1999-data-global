module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapItem105", package.seeall)

slot0 = class("VersionActivity_1_2_DungeonMapItem105", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rotate/layout/top/title/#txt_title")
	slot0._gopickupbg = gohelper.findChild(slot0.viewGO, "rotate/#go_pickupbg")
	slot0._gopickup = gohelper.findChild(slot0.viewGO, "rotate/#go_pickupbg/#go_pickup")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "rotate/#go_pickupbg/#go_pickup/#txt_content")
	slot0._goop = gohelper.findChild(slot0.viewGO, "rotate/#go_op")
	slot0._txtdoit = gohelper.findChildText(slot0.viewGO, "rotate/#go_op/bg/#txt_doit")
	slot0._btndoit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op/bg/#btn_doit")
	slot0._simagebgimag = gohelper.findChildSingleImage(slot0.viewGO, "rotate/#go_pickupbg/bgimag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btndoit:AddClickListener(slot0._btndoitOnClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btndoit:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:_onBtnCloseSelf()
end

function slot0._onBtnCloseSelf(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("close", slot0.DESTROYSELF, slot0)
end

function slot0._btndoitOnClick(slot0)
	if slot0._finishedFight then
		DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	else
		slot1 = tonumber(slot0._config.param)
		DungeonModel.instance.curLookEpisodeId = slot1

		if TeachNoteModel.instance:isTeachNoteEpisode(slot1) then
			TeachNoteController.instance:enterTeachNoteDetailView(slot1)
		else
			DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	end

	slot0:DESTROYSELF()
end

function slot0._editableInitView(slot0)
	slot0._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._config = slot1
end

function slot0.onOpen(slot0)
	slot0._finishedFight = DungeonModel.instance:hasPassLevel(tonumber(slot0._config.param))

	if slot0._finishedFight then
		slot0._txtcontent.text = slot0._config.finishText
		slot0._txtdoit.text = luaLang("confirm_text")
	else
		slot0._txtcontent.text = slot0._config.desc
		slot0._txtdoit.text = slot0._config.acceptText
	end

	slot0._txttitle.text = slot0._config.title
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebgimag:UnLoadImage()
end

return slot0
