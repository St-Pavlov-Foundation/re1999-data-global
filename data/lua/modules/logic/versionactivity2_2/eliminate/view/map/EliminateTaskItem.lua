module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateTaskItem", package.seeall)

local var_0_0 = class("EliminateTaskItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0.txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0.txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0.txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0.scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0.goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0.goDoing = gohelper.findChild(arg_1_0.viewGO, "#go_normal/txt_finishing")
	arg_1_0.btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0.goRunning = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_running")
	arg_1_0.btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0.btnFinishAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall")
	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)

	arg_1_0.animatorPlayer:Play(UIAnimationName.Open)

	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnNotFinish:AddClickListener(arg_2_0._btnNotFinishOnClick, arg_2_0)
	arg_2_0.btnFinish:AddClickListener(arg_2_0._btnFinishOnClick, arg_2_0)
	arg_2_0.btnFinishAll:AddClickListener(arg_2_0._btnFinishAllOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.btnNotFinish:RemoveClickListener()
	arg_3_0.btnFinish:RemoveClickListener()
	arg_3_0.btnFinishAll:RemoveClickListener()
end

function var_0_0._btnNotFinishOnClick(arg_4_0)
	if arg_4_0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
		ViewMgr.instance:closeView(ViewName.EliminateTaskView)
	end
end

function var_0_0._btnFinishAllOnClick(arg_5_0)
	arg_5_0:_btnFinishOnClick()
end

var_0_0.FinishKey = "EliminateTaskItem FinishKey"

function var_0_0._btnFinishOnClick(arg_6_0)
	UIBlockMgr.instance:startBlock(var_0_0.FinishKey)

	arg_6_0.animator.speed = 1

	arg_6_0.animatorPlayer:Play(UIAnimationName.Finish, arg_6_0.firstAnimationDone, arg_6_0)
end

function var_0_0.firstAnimationDone(arg_7_0)
	arg_7_0._view.viewContainer.taskAnimRemoveItem:removeByIndex(arg_7_0._index, arg_7_0.secondAnimationDone, arg_7_0)
end

function var_0_0.secondAnimationDone(arg_8_0)
	UIBlockMgr.instance:endBlock(var_0_0.FinishKey)
	arg_8_0.animatorPlayer:Play(UIAnimationName.Idle)

	if arg_8_0.taskMo.getAll then
		EliminateRpc.instance:sendGetMatch3WarChessTaskRewardRequest(0)
	else
		EliminateRpc.instance:sendGetMatch3WarChessTaskRewardRequest(arg_8_0.co.id)
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.rewardItemList = {}
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0.taskMo = arg_10_1
	arg_10_0.scrollReward.parentGameObject = arg_10_0._view._csListScroll.gameObject

	gohelper.setActive(arg_10_0._gonormal, not arg_10_0.taskMo.getAll)
	gohelper.setActive(arg_10_0._gogetall, arg_10_0.taskMo.getAll)

	if arg_10_0.taskMo.getAll then
		arg_10_0:refreshGetAllUI()
	else
		arg_10_0:refreshNormalUI()
	end
end

function var_0_0.refreshNormalUI(arg_11_0)
	arg_11_0.co = arg_11_0.taskMo.config
	arg_11_0.txttaskdesc.text = arg_11_0.co.desc
	arg_11_0.txtnum.text = arg_11_0.taskMo.progress
	arg_11_0.txttotal.text = arg_11_0.co.maxProgress

	if arg_11_0.taskMo.finishCount >= arg_11_0.co.maxFinishCount then
		gohelper.setActive(arg_11_0.goDoing, false)
		gohelper.setActive(arg_11_0.btnNotFinish, false)
		gohelper.setActive(arg_11_0.goRunning, false)
		gohelper.setActive(arg_11_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_11_0.goFinished, true)
	elseif arg_11_0.taskMo.hasFinished then
		gohelper.setActive(arg_11_0.btnFinish, true)
		gohelper.setActive(arg_11_0.btnNotFinish, false)
		gohelper.setActive(arg_11_0.goDoing, false)
		gohelper.setActive(arg_11_0.goRunning, false)
		gohelper.setActive(arg_11_0.goFinished, false)
	else
		if arg_11_0.co.jumpId ~= 0 then
			gohelper.setActive(arg_11_0.btnNotFinish, true)
			gohelper.setActive(arg_11_0.goDoing, false)
			gohelper.setActive(arg_11_0.goRunning, false)
		else
			gohelper.setActive(arg_11_0.btnNotFinish, false)
			gohelper.setActive(arg_11_0.goDoing, true)
			gohelper.setActive(arg_11_0.goRunning, true)
		end

		gohelper.setActive(arg_11_0.goFinished, false)
		gohelper.setActive(arg_11_0.btnFinish.gameObject, false)
	end

	arg_11_0:refreshRewardItems()
end

function var_0_0.refreshRewardItems(arg_12_0)
	local var_12_0 = arg_12_0.co.bonus

	if string.nilorempty(var_12_0) then
		gohelper.setActive(arg_12_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_12_0.scrollReward.gameObject, true)

	local var_12_1 = GameUtil.splitString2(var_12_0, true, "|", "#")

	arg_12_0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_12_1 > 2

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = iter_12_1[1]
		local var_12_3 = iter_12_1[2]
		local var_12_4 = iter_12_1[3]
		local var_12_5 = arg_12_0.rewardItemList[iter_12_0]

		if not var_12_5 then
			var_12_5 = IconMgr.instance:getCommonPropItemIcon(arg_12_0.goRewardContent)

			transformhelper.setLocalScale(var_12_5.go.transform, 1, 1, 1)
			var_12_5:setMOValue(var_12_2, var_12_3, var_12_4, nil, true)
			var_12_5:setCountFontSize(26)
			var_12_5:showStackableNum2()
			var_12_5:isShowEffect(true)
			table.insert(arg_12_0.rewardItemList, var_12_5)

			local var_12_6 = var_12_5:getItemIcon():getCountBg()
			local var_12_7 = var_12_5:getItemIcon():getCount()

			transformhelper.setLocalScale(var_12_6.transform, 1, 1.5, 1)
			transformhelper.setLocalScale(var_12_7.transform, 1.5, 1.5, 1)
		else
			var_12_5:setMOValue(var_12_2, var_12_3, var_12_4, nil, true)
		end

		gohelper.setActive(var_12_5.go, true)
	end

	for iter_12_2 = #var_12_1 + 1, #arg_12_0.rewardItemList do
		gohelper.setActive(arg_12_0.rewardItemList[iter_12_2].go, false)
	end

	arg_12_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0.refreshGetAllUI(arg_13_0)
	return
end

function var_0_0.canGetReward(arg_14_0)
	return arg_14_0.taskMo.finishCount < arg_14_0.co.maxFinishCount and arg_14_0.taskMo.hasFinished
end

function var_0_0.getAnimator(arg_15_0)
	return arg_15_0.animator
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagenormalbg:UnLoadImage()
	arg_16_0._simagegetallbg:UnLoadImage()
end

return var_0_0
