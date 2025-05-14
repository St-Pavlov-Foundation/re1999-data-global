module("modules.logic.versionactivity.view.VersionActivityTaskItem", package.seeall)

local var_0_0 = class("VersionActivityTaskItem", ListScrollCell)

var_0_0.episodeColor = "#C05216"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_bg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/info/#txt_desc")
	arg_1_0._gomode = gohelper.findChild(arg_1_0.viewGO, "#go_normal/info/#go_mode")
	arg_1_0._gostorymode1 = gohelper.findChild(arg_1_0.viewGO, "#go_normal/info/#go_mode/#go_storymode1")
	arg_1_0._gostorymode2 = gohelper.findChild(arg_1_0.viewGO, "#go_normal/info/#go_mode/#go_storymode2")
	arg_1_0._gostorymode3 = gohelper.findChild(arg_1_0.viewGO, "#go_normal/info/#go_mode/#go_storymode3")
	arg_1_0._gohardmode = gohelper.findChild(arg_1_0.viewGO, "#go_normal/info/#go_mode/#go_hardmode")
	arg_1_0._txtremaindesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/info/#txt_remaindesc")
	arg_1_0._txtpointcount = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_pointcount")
	arg_1_0._txtcurprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_curprogress")
	arg_1_0._txttotalprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_totalprogress")
	arg_1_0._imagefull = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/progress/probarbg/#image_full")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_jump")
	arg_1_0._btnreceive = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_receive")
	arg_1_0._btnhasgot = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_hasgot")
	arg_1_0._gofinishmask = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_finishmask")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0._gogetall, "bg")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0._gogetall, "#btn_getall")
	arg_1_0._txtrewardcount = gohelper.findChildText(arg_1_0._gogetall, "#txt_pointcount")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btnreceive:AddClickListener(arg_2_0._btnreceiveOnClick, arg_2_0)
	arg_2_0._btnhasgot:AddClickListener(arg_2_0._btnhasgotOnClick, arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btnreceive:RemoveClickListener()
	arg_3_0._btnhasgot:RemoveClickListener()
	arg_3_0._btngetall:RemoveClickListener()
end

function var_0_0._btnjumpOnClick(arg_4_0)
	if arg_4_0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(arg_4_0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivityTaskView)
		end
	end
end

function var_0_0._btnhasgotOnClick(arg_5_0)
	return
end

function var_0_0._btngetallOnClick(arg_6_0)
	arg_6_0:_btnreceiveOnClick()
end

var_0_0.FinishAnimationBlockKey = "FinishAnimationBlockKey"

function var_0_0._btnreceiveOnClick(arg_7_0)
	if arg_7_0.taskMo.getAll then
		arg_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_7_0._gogetall)
	else
		arg_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_7_0._gonormal)
	end

	gohelper.setActive(arg_7_0._gofinishmask, true)

	arg_7_0._animator.speed = 1

	UIBlockMgr.instance:startBlock(var_0_0.FinishAnimationBlockKey)
	arg_7_0.animatorPlayer:Play("finish", arg_7_0.onFinishFirstPartAnimationDone, arg_7_0)
end

function var_0_0.onFinishFirstPartAnimationDone(arg_8_0)
	arg_8_0._view.viewContainer.taskAnimRemoveItem:removeByIndex(arg_8_0._index, arg_8_0.onFinishSecondPartAnimationDone, arg_8_0)
end

function var_0_0.onFinishSecondPartAnimationDone(arg_9_0)
	VersionActivityTaskBonusListModel.instance:recordPrefixActivityPointCount()

	if arg_9_0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, arg_9_0.onReceiveReply, arg_9_0, VersionActivityEnum.ActivityId.Act113)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_9_0.co.id, arg_9_0.onReceiveReply, arg_9_0)
	end

	UIBlockMgr.instance:endBlock(var_0_0.FinishAnimationBlockKey)
end

function var_0_0.onReceiveReply(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == 0 then
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnReceiveFinishTaskReply)
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("img_di2"))
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0.taskMo = arg_12_1

	gohelper.setActive(arg_12_0._gonormal, not arg_12_0.taskMo.getAll)
	gohelper.setActive(arg_12_0._gogetall, arg_12_0.taskMo.getAll)

	if arg_12_0.taskMo.getAll then
		arg_12_0:refreshGetAllUI()

		arg_12_0._animator = arg_12_0._gogetall:GetComponent(typeof(UnityEngine.Animator))
	else
		arg_12_0:refreshNormalUI()

		arg_12_0._animator = arg_12_0._gonormal:GetComponent(typeof(UnityEngine.Animator))
	end
end

function var_0_0.refreshNormalUI(arg_13_0)
	arg_13_0.co = arg_13_0.taskMo.config

	arg_13_0:refreshDesc()

	arg_13_0._txtpointcount.text = luaLang("multiple") .. arg_13_0.co.activity
	arg_13_0._txtcurprogress.text = arg_13_0.taskMo.progress
	arg_13_0._txttotalprogress.text = arg_13_0.co.maxProgress
	arg_13_0._imagefull.fillAmount = arg_13_0.taskMo.progress / arg_13_0.co.maxProgress

	if arg_13_0.taskMo.finishCount >= arg_13_0.co.maxFinishCount then
		gohelper.setActive(arg_13_0._btnjump.gameObject, false)
		gohelper.setActive(arg_13_0._btnreceive.gameObject, false)
		gohelper.setActive(arg_13_0._btnhasgot.gameObject, true)
		gohelper.setActive(arg_13_0._gofinishmask, true)
	elseif arg_13_0.taskMo.hasFinished then
		gohelper.setActive(arg_13_0._btnreceive.gameObject, true)
		gohelper.setActive(arg_13_0._btnjump.gameObject, false)
		gohelper.setActive(arg_13_0._btnhasgot.gameObject, false)
		gohelper.setActive(arg_13_0._gofinishmask, false)
	else
		gohelper.setActive(arg_13_0._btnjump.gameObject, true)
		gohelper.setActive(arg_13_0._btnreceive.gameObject, false)
		gohelper.setActive(arg_13_0._btnhasgot.gameObject, false)
		gohelper.setActive(arg_13_0._gofinishmask, false)
	end
end

function var_0_0.refreshDesc(arg_14_0)
	local var_14_0 = arg_14_0.co.desc
	local var_14_1, var_14_2, var_14_3 = string.match(var_14_0, "(.-)%[(.-)%](.+)")
	local var_14_4 = false

	if var_14_2 then
		arg_14_0:clearModeStatus()

		if var_14_2 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story1]) then
			gohelper.setActive(arg_14_0._gostorymode1, true)

			var_14_4 = true
		elseif var_14_2 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story2]) then
			gohelper.setActive(arg_14_0._gostorymode2, true)

			var_14_4 = true
		elseif var_14_2 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story3]) then
			gohelper.setActive(arg_14_0._gostorymode3, true)

			var_14_4 = true
		elseif var_14_2 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Hard]) then
			gohelper.setActive(arg_14_0._gohardmode, true)

			var_14_4 = true
		end
	end

	var_14_1 = var_14_1 or arg_14_0.co.desc

	local var_14_5 = string.gsub(var_14_1, "(TRC%-%d+)", "<color=#C05216>%1</color>")

	arg_14_0._txtdesc.text = var_14_5

	gohelper.setActive(arg_14_0._gomode, var_14_4)

	if var_14_4 then
		arg_14_0._txtremaindesc.text = var_14_3
	else
		arg_14_0._txtremaindesc.text = ""
	end
end

function var_0_0.refreshGetAllUI(arg_15_0)
	arg_15_0._simagegetallbg:LoadImage(ResUrl.getVersionActivityIcon("xuanzhong"))

	arg_15_0._txtrewardcount.text = string.format("<size=30>%s</size>%s", luaLang("multiple"), VersionActivityTaskListModel.instance:getFinishTaskActivityCount())
end

function var_0_0.canGetReward(arg_16_0)
	return arg_16_0.taskMo.finishCount < arg_16_0.co.maxFinishCount and arg_16_0.taskMo.hasFinished
end

function var_0_0.getAnimator(arg_17_0)
	return arg_17_0._animator
end

function var_0_0.clearModeStatus(arg_18_0)
	gohelper.setActive(arg_18_0._gostorymode1, false)
	gohelper.setActive(arg_18_0._gostorymode2, false)
	gohelper.setActive(arg_18_0._gostorymode3, false)
	gohelper.setActive(arg_18_0._gohardmode, false)
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._simagebg:UnLoadImage()
	arg_19_0._simagegetallbg:UnLoadImage()

	if arg_19_0.animatorPlayer then
		arg_19_0.animatorPlayer:Stop()
	end
end

return var_0_0
