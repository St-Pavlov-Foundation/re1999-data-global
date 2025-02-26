module("modules.logic.seasonver.act123.view.Season123TaskMapItem", package.seeall)

slot0 = class("Season123TaskMapItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.param = slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.stage = slot0.param.stage
	slot0.actId = slot0.param.actId
	slot0._goroot = gohelper.findChild(slot0.go, "root")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.go, "root/#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.go, "root/#txt_name")
	slot0._imagechapternum = gohelper.findChildImage(slot0.go, "root/#image_chapternum")
	slot0._goprogress = gohelper.findChild(slot0.go, "root/#go_progress")
	slot0._gofinish = gohelper.findChild(slot0.go, "root/#image_finish")
	slot0._txttime = gohelper.findChildText(slot0.go, "root/#image_finish/#txt_time")
	slot5 = UnityEngine.CanvasGroup
	slot0._canvasGroup = slot0.go:GetComponent(typeof(slot5))
	slot0.progressItemList = slot0:getUserDataTb_()

	for slot5 = 1, 5 do
		slot6 = {
			progressGO = gohelper.findChild(slot0._goprogress, "#go_progress" .. slot5)
		}
		slot6.darkIcon = gohelper.findChild(slot6.progressGO, "dark")
		slot6.lightIcon = gohelper.findChild(slot6.progressGO, "light")
		slot6.redIcon = gohelper.findChild(slot6.progressGO, "red")

		table.insert(slot0.progressItemList, slot6)
	end

	slot0.goreddot = gohelper.findChild(slot0.go, "root/#go_reddot")

	RedDotController.instance:addRedDot(slot0.goreddot, RedDotEnum.DotNode.Season123StageReward, slot0.stage)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, slot0.setScale, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, slot0.setScale, slot0)
end

function slot0.onMapItemClick(slot0)
	if Season123TaskModel.instance.curStage == slot0.stage then
		return
	end

	Season123TaskModel.instance.curStage = slot0.stage

	if Season123TaskModel.instance.curTaskType == Activity123Enum.TaskRewardViewType then
		Season123TaskModel.instance:refreshList(slot1)
	end

	Season123Controller.instance:dispatchEvent(Season123Event.clickTaskMapItem)
end

function slot0.refreshUI(slot0)
	slot3 = Season123Model.instance:getActInfo(slot0.actId)
	slot4, slot5 = slot3:getStageRewardCount(slot0.stage)

	slot0._simageicon:LoadImage(ResUrl.getSeason123Icon(Season123Model.instance:getSingleBgFolder(), "v1a7_season_pic_" .. slot0.stage))
	UISpriteSetMgr.instance:setSeason123Sprite(slot0._imagechapternum, "v1a7_season_num_" .. slot0.stage, true)

	slot0._txtname.text = Season123Config.instance:getStageCos(slot0.actId)[slot0.stage].name

	if slot3.stageMap[slot0.stage] then
		slot8 = slot7.minRound
		slot0._txttime.text = tostring(slot8)

		gohelper.setActive(slot0._gofinish, slot8 > 0)
	else
		gohelper.setActive(slot0._gofinish, false)
	end

	for slot11 = 1, slot5 do
		gohelper.setActive(slot0.progressItemList[slot11].progressGO, true)
		gohelper.setActive(slot0.progressItemList[slot11].lightIcon, slot11 <= slot4 and slot11 ~= slot5)
		gohelper.setActive(slot0.progressItemList[slot11].darkIcon, slot4 < slot11 and slot4 < slot5)
		gohelper.setActive(slot0.progressItemList[slot11].redIcon, slot11 == slot4 and slot11 == slot5)
	end

	for slot11 = slot5 + 1, #slot0.progressItemList do
		gohelper.setActive(slot0.progressItemList[slot11].progressGO, false)
	end

	slot0._canvasGroup.alpha = Season123TaskModel.instance.curStage == slot0.stage and 1 or 0.5
	slot8 = Season123TaskModel.instance.curStage == slot0.stage and 1 or 0.7

	transformhelper.setLocalScale(slot0._goroot.transform, slot8, slot8, slot8)
end

function slot0.setScale(slot0)
	if Season123TaskModel.instance.curStage == slot0.stage then
		slot0.scaleTweenId = ZProj.TweenHelper.DOScale(slot0._goroot.transform, 1, 1, 1, 0.5)
		slot0.canvasTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0.go, slot0._canvasGroup.alpha, 1, 0.5)
	else
		slot0.scaleTweenId = ZProj.TweenHelper.DOScale(slot0._goroot.transform, 0.7, 0.7, 0.7, 0.5)
		slot0.canvasTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0.go, slot0._canvasGroup.alpha, 0.5, 0.5)
	end
end

function slot0.onDestroy(slot0)
	slot0:__onDispose()

	if slot0.scaleTweenId then
		ZProj.TweenHelper.KillById(slot0.scaleTweenId)
	end

	if slot0.canvasTweenId then
		ZProj.TweenHelper.KillById(slot0.canvasTweenId)
	end
end

return slot0
