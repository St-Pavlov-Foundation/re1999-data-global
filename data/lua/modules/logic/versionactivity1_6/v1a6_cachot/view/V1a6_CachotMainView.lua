module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotMainView", package.seeall)

slot0 = class("V1a6_CachotMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "title/#txt_title")
	slot0._btncollection = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_collection")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reward")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_reddot")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "#btn_reward/scorebg/#txt_score")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#btn_reward/scorebg/#txt_score/#simage_icon")
	slot0._gocontrol = gohelper.findChild(slot0.viewGO, "#go_control")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncollection:AddClickListener(slot0._btncollectionOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncollection:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
end

function slot0._btnrewardOnClick(slot0)
	V1a6_CachotController.instance:openV1a6_CachotProgressView()
end

function slot0._btncollectionOnClick(slot0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionView()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()
	slot0._txtscore.text = slot0.stateMo.totalScore

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_interface_open)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
