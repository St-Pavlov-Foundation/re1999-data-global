module("modules.logic.rouge.view.RougeFavoriteView", package.seeall)

slot0 = class("RougeFavoriteView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._gorole4 = gohelper.findChild(slot0.viewGO, "#go_role4")
	slot0._gorole3 = gohelper.findChild(slot0.viewGO, "#go_role3")
	slot0._goluoleilai = gohelper.findChild(slot0.viewGO, "#go_luoleilai")
	slot0._gorole2 = gohelper.findChild(slot0.viewGO, "#go_role2")
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "#go_role1")
	slot0._gohailuo = gohelper.findChild(slot0.viewGO, "#go_hailuo")
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_story")
	slot0._gonewstory = gohelper.findChild(slot0.viewGO, "Left/#btn_story/#go_new_story")
	slot0._btnillustration = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_illustration")
	slot0._gonewillustration = gohelper.findChild(slot0.viewGO, "Left/#btn_illustration/#go_new_illustration")
	slot0._btnfaction = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_faction")
	slot0._gonewfaction = gohelper.findChild(slot0.viewGO, "Left/#btn_faction/#go_new_faction")
	slot0._btnresult = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_result")
	slot0._btncollection = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_collection")
	slot0._gonewcollection = gohelper.findChild(slot0.viewGO, "Left/#btn_collection/#go_new_collection")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstory:AddClickListener(slot0._btnstoryOnClick, slot0)
	slot0._btnillustration:AddClickListener(slot0._btnillustrationOnClick, slot0)
	slot0._btnfaction:AddClickListener(slot0._btnfactionOnClick, slot0)
	slot0._btnresult:AddClickListener(slot0._btnresultOnClick, slot0)
	slot0._btncollection:AddClickListener(slot0._btncollectionOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstory:RemoveClickListener()
	slot0._btnillustration:RemoveClickListener()
	slot0._btnfaction:RemoveClickListener()
	slot0._btnresult:RemoveClickListener()
	slot0._btncollection:RemoveClickListener()
end

function slot0._btnresultOnClick(slot0)
	RougeController.instance:openRougeResultReportView()
end

function slot0._btncollectionOnClick(slot0)
	RougeController.instance:openRougeFavoriteCollectionView()
end

function slot0._btnfactionOnClick(slot0)
	RougeController.instance:openRougeFactionIllustrationView()
end

function slot0._btnillustrationOnClick(slot0)
	RougeController.instance:openRougeIllustrationListView()
end

function slot0._btnstoryOnClick(slot0)
	RougeController.instance:openRougeReviewView()
end

function slot0._editableInitView(slot0)
	slot0:_updateNewFlag()
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, slot0._updateNewFlag, slot0)
end

function slot0._updateNewFlag(slot0)
	gohelper.setActive(slot0._gonewstory, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Story) > 0)
	gohelper.setActive(slot0._gonewillustration, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Illustration) > 0)
	gohelper.setActive(slot0._gonewfaction, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Faction) > 0)
	gohelper.setActive(slot0._gonewcollection, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Collection) > 0)
end

function slot0.showEnding(slot0)
	gohelper.setActive(slot0._gohailuo, RougeOutsideModel.instance:getRougeGameRecord().passEndIdMap[string.splitToNumber(RougeConfig1.instance:getConstValueByID(RougeEnum.Const.FavoriteEndingShow), "#")[1]] ~= nil)
	gohelper.setActive(slot0._goluoleilai, slot3.passEndIdMap[slot2[2]] ~= nil)
end

function slot0.randomRoleShow(slot0)
	if slot0["_gorole" .. math.random(1, 5)] then
		gohelper.setActive(slot2, true)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:randomRoleShow()
	slot0:showEnding()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
