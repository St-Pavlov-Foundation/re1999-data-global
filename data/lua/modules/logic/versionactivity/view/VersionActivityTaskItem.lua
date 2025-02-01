module("modules.logic.versionactivity.view.VersionActivityTaskItem", package.seeall)

slot0 = class("VersionActivityTaskItem", ListScrollCell)
slot0.episodeColor = "#C05216"

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_bg")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_normal/info/#txt_desc")
	slot0._gomode = gohelper.findChild(slot0.viewGO, "#go_normal/info/#go_mode")
	slot0._gostorymode1 = gohelper.findChild(slot0.viewGO, "#go_normal/info/#go_mode/#go_storymode1")
	slot0._gostorymode2 = gohelper.findChild(slot0.viewGO, "#go_normal/info/#go_mode/#go_storymode2")
	slot0._gostorymode3 = gohelper.findChild(slot0.viewGO, "#go_normal/info/#go_mode/#go_storymode3")
	slot0._gohardmode = gohelper.findChild(slot0.viewGO, "#go_normal/info/#go_mode/#go_hardmode")
	slot0._txtremaindesc = gohelper.findChildText(slot0.viewGO, "#go_normal/info/#txt_remaindesc")
	slot0._txtpointcount = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_pointcount")
	slot0._txtcurprogress = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_curprogress")
	slot0._txttotalprogress = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_totalprogress")
	slot0._imagefull = gohelper.findChildImage(slot0.viewGO, "#go_normal/progress/probarbg/#image_full")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_jump")
	slot0._btnreceive = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_receive")
	slot0._btnhasgot = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_hasgot")
	slot0._gofinishmask = gohelper.findChild(slot0.viewGO, "#go_normal/#go_finishmask")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0._gogetall, "bg")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0._gogetall, "#btn_getall")
	slot0._txtrewardcount = gohelper.findChildText(slot0._gogetall, "#txt_pointcount")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btnreceive:AddClickListener(slot0._btnreceiveOnClick, slot0)
	slot0._btnhasgot:AddClickListener(slot0._btnhasgotOnClick, slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnjump:RemoveClickListener()
	slot0._btnreceive:RemoveClickListener()
	slot0._btnhasgot:RemoveClickListener()
	slot0._btngetall:RemoveClickListener()
end

function slot0._btnjumpOnClick(slot0)
	if slot0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(slot0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivityTaskView)
		end
	end
end

function slot0._btnhasgotOnClick(slot0)
end

function slot0._btngetallOnClick(slot0)
	slot0:_btnreceiveOnClick()
end

slot0.FinishAnimationBlockKey = "FinishAnimationBlockKey"

function slot0._btnreceiveOnClick(slot0)
	if slot0.taskMo.getAll then
		slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gogetall)
	else
		slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gonormal)
	end

	gohelper.setActive(slot0._gofinishmask, true)

	slot0._animator.speed = 1

	UIBlockMgr.instance:startBlock(uv0.FinishAnimationBlockKey)
	slot0.animatorPlayer:Play("finish", slot0.onFinishFirstPartAnimationDone, slot0)
end

function slot0.onFinishFirstPartAnimationDone(slot0)
	slot0._view.viewContainer.taskAnimRemoveItem:removeByIndex(slot0._index, slot0.onFinishSecondPartAnimationDone, slot0)
end

function slot0.onFinishSecondPartAnimationDone(slot0)
	VersionActivityTaskBonusListModel.instance:recordPrefixActivityPointCount()

	if slot0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, , slot0.onReceiveReply, slot0, VersionActivityEnum.ActivityId.Act113)
	else
		TaskRpc.instance:sendFinishTaskRequest(slot0.co.id, slot0.onReceiveReply, slot0)
	end

	UIBlockMgr.instance:endBlock(uv0.FinishAnimationBlockKey)
end

function slot0.onReceiveReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnReceiveFinishTaskReply)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("img_di2"))
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.taskMo = slot1

	gohelper.setActive(slot0._gonormal, not slot0.taskMo.getAll)
	gohelper.setActive(slot0._gogetall, slot0.taskMo.getAll)

	if slot0.taskMo.getAll then
		slot0:refreshGetAllUI()

		slot0._animator = slot0._gogetall:GetComponent(typeof(UnityEngine.Animator))
	else
		slot0:refreshNormalUI()

		slot0._animator = slot0._gonormal:GetComponent(typeof(UnityEngine.Animator))
	end
end

function slot0.refreshNormalUI(slot0)
	slot0.co = slot0.taskMo.config

	slot0:refreshDesc()

	slot0._txtpointcount.text = luaLang("multiple") .. slot0.co.activity
	slot0._txtcurprogress.text = slot0.taskMo.progress
	slot0._txttotalprogress.text = slot0.co.maxProgress
	slot0._imagefull.fillAmount = slot0.taskMo.progress / slot0.co.maxProgress

	if slot0.co.maxFinishCount <= slot0.taskMo.finishCount then
		gohelper.setActive(slot0._btnjump.gameObject, false)
		gohelper.setActive(slot0._btnreceive.gameObject, false)
		gohelper.setActive(slot0._btnhasgot.gameObject, true)
		gohelper.setActive(slot0._gofinishmask, true)
	elseif slot0.taskMo.hasFinished then
		gohelper.setActive(slot0._btnreceive.gameObject, true)
		gohelper.setActive(slot0._btnjump.gameObject, false)
		gohelper.setActive(slot0._btnhasgot.gameObject, false)
		gohelper.setActive(slot0._gofinishmask, false)
	else
		gohelper.setActive(slot0._btnjump.gameObject, true)
		gohelper.setActive(slot0._btnreceive.gameObject, false)
		gohelper.setActive(slot0._btnhasgot.gameObject, false)
		gohelper.setActive(slot0._gofinishmask, false)
	end
end

function slot0.refreshDesc(slot0)
	slot2, slot3, slot4 = string.match(slot0.co.desc, "(.-)%[(.-)%](.+)")
	slot5 = false

	if slot3 then
		slot0:clearModeStatus()

		if slot3 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story1]) then
			gohelper.setActive(slot0._gostorymode1, true)

			slot5 = true
		elseif slot3 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story2]) then
			gohelper.setActive(slot0._gostorymode2, true)

			slot5 = true
		elseif slot3 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story3]) then
			gohelper.setActive(slot0._gostorymode3, true)

			slot5 = true
		elseif slot3 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Hard]) then
			gohelper.setActive(slot0._gohardmode, true)

			slot5 = true
		end
	end

	slot0._txtdesc.text = string.gsub(slot2 or slot0.co.desc, "(TRC%-%d+)", "<color=#C05216>%1</color>")

	gohelper.setActive(slot0._gomode, slot5)

	if slot5 then
		slot0._txtremaindesc.text = slot4
	else
		slot0._txtremaindesc.text = ""
	end
end

function slot0.refreshGetAllUI(slot0)
	slot0._simagegetallbg:LoadImage(ResUrl.getVersionActivityIcon("xuanzhong"))

	slot0._txtrewardcount.text = string.format("<size=30>%s</size>%s", luaLang("multiple"), VersionActivityTaskListModel.instance:getFinishTaskActivityCount())
end

function slot0.canGetReward(slot0)
	return slot0.taskMo.finishCount < slot0.co.maxFinishCount and slot0.taskMo.hasFinished
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.clearModeStatus(slot0)
	gohelper.setActive(slot0._gostorymode1, false)
	gohelper.setActive(slot0._gostorymode2, false)
	gohelper.setActive(slot0._gostorymode3, false)
	gohelper.setActive(slot0._gohardmode, false)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagegetallbg:UnLoadImage()

	if slot0.animatorPlayer then
		slot0.animatorPlayer:Stop()
	end
end

return slot0
