module("modules.logic.meilanni.view.MeilanniTaskItem", package.seeall)

local var_0_0 = class("MeilanniTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_bg")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_rewards/#go_rewarditem")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_notget")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	arg_1_0._goblackmask = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_blackmask")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_get")
	arg_1_0._imagelevelbg = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/#image_levelbg")
	arg_1_0._simagelevel = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_level")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._btncollectall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/go_getall/#btn_collectall")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
	arg_2_0._btncollectall:AddClickListener(arg_2_0._btncollectallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
	arg_3_0._btncollectall:RemoveClickListener()
end

function var_0_0._btncollectallOnClick(arg_4_0)
	arg_4_0:_collect()
end

function var_0_0._btnnotfinishbgOnClick(arg_5_0)
	local var_5_0 = arg_5_0._mo.mapId
	local var_5_1 = lua_activity108_map.configDict[var_5_0]

	if MeilanniMapItem.isLock(var_5_1) then
		GameFacade.showToast(ToastEnum.MeilanniTask)

		return
	end

	MeilanniMapItem.gotoMap(var_5_0)
end

function var_0_0._btnfinishbgOnClick(arg_6_0)
	arg_6_0:_collect()
end

function var_0_0._collect(arg_7_0)
	if arg_7_0._mo.isGetAll then
		arg_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_7_0._gogetall)
	else
		arg_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_7_0._gonormal)
	end

	arg_7_0._animator.speed = 1

	arg_7_0.animatorPlayer:Play("finish", arg_7_0.onFinishFirstPartAnimationDone, arg_7_0)
end

function var_0_0.onFinishFirstPartAnimationDone(arg_8_0)
	arg_8_0._view.viewContainer.taskAnimRemoveItem:removeByIndex(arg_8_0._index, arg_8_0.onFinishSecondPartAnimationDone, arg_8_0)
end

function var_0_0.onFinishSecondPartAnimationDone(arg_9_0)
	Activity108Rpc.instance:sendGet108BonusRequest(MeilanniEnum.activityId, arg_9_0._mo.id)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._rewardItems = arg_10_0:getUserDataTb_()

	arg_10_0._simagegetallbg:LoadImage(ResUrl.getMeilanniIcon("bg_rwdi_1"))
	arg_10_0._simagebg:LoadImage(ResUrl.getMeilanniIcon("bg_rwdi_2"))
end

function var_0_0._editableAddEvents(arg_11_0)
	gohelper.addUIClickAudio(arg_11_0._btnnotfinishbg.gameObject, AudioEnum.Meilanni.play_ui_mln_move)
	gohelper.addUIClickAudio(arg_11_0._btnfinishbg.gameObject, AudioEnum.Meilanni.play_ui_mln_receive)
	gohelper.addUIClickAudio(arg_11_0._btncollectall.gameObject, AudioEnum.Meilanni.play_ui_mln_receive)
end

function var_0_0._editableRemoveEvents(arg_12_0)
	return
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._mo = arg_13_1
	arg_13_0._canGet = false

	gohelper.setActive(arg_13_0._gonormal, not arg_13_1.isGetAll)
	gohelper.setActive(arg_13_0._gogetall, arg_13_1.isGetAll)

	if arg_13_1.isGetAll then
		arg_13_0._canGet = true
		arg_13_0._animator = arg_13_0._gogetall:GetComponent(typeof(UnityEngine.Animator))

		return
	end

	arg_13_0._animator = arg_13_0._gonormal:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._txttaskdes.text = arg_13_1.desc

	local var_13_0 = MeilanniModel.instance:getMapInfo(arg_13_1.mapId)
	local var_13_1 = var_13_0 and var_13_0:getMaxScore() or 0
	local var_13_2 = arg_13_1.score
	local var_13_3 = var_13_0 and var_13_0:isGetReward(arg_13_0._mo.id)

	gohelper.setActive(arg_13_0._gonotget, not var_13_3)
	gohelper.setActive(arg_13_0._goget, var_13_3)
	gohelper.setActive(arg_13_0._goblackmask, var_13_3)

	if not var_13_3 then
		local var_13_4 = var_13_2 <= var_13_1

		gohelper.setActive(arg_13_0._btnnotfinishbg.gameObject, not var_13_4)
		gohelper.setActive(arg_13_0._btnfinishbg.gameObject, var_13_4)

		arg_13_0._canGet = var_13_4
	end

	local var_13_5 = MeilanniConfig.instance:getScoreIndex(arg_13_1.score)

	if var_13_3 or arg_13_0._canGet then
		arg_13_0._simagelevel:LoadImage(ResUrl.getMeilanniLangIcon("bg_jiangli_pingfen_" .. var_13_5))
	else
		arg_13_0._simagelevel:LoadImage(ResUrl.getMeilanniLangIcon("bg_jiangli_pingfen_" .. var_13_5 .. "_dis"))
	end

	arg_13_0:_addRewards()
end

function var_0_0._addRewards(arg_14_0)
	arg_14_0._rewardItems = arg_14_0._rewardItems or arg_14_0:getUserDataTb_()

	local var_14_0 = string.split(arg_14_0._mo.bonus, "|")

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = string.splitToNumber(var_14_0[iter_14_0], "#")

		arg_14_0:_showItem(iter_14_0, var_14_1)
	end
end

function var_0_0._showItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._rewardItems[arg_15_1]

	if not var_15_0 then
		var_15_0 = {
			parentGo = gohelper.cloneInPlace(arg_15_0._gorewarditem)
		}

		gohelper.setActive(var_15_0.parentGo, true)

		var_15_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_15_0.parentGo)

		var_15_0.itemIcon:isShowCount(arg_15_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_15_0.itemIcon:showStackableNum2()
		var_15_0.itemIcon:setHideLvAndBreakFlag(true)
		var_15_0.itemIcon:hideEquipLvAndBreak(true)

		arg_15_0._rewardItems[arg_15_1] = var_15_0
	end

	var_15_0.itemIcon:setMOValue(arg_15_2[1], arg_15_2[2], arg_15_2[3], nil, true)
	var_15_0.itemIcon:setCountFontSize(40)
end

function var_0_0.onSelect(arg_16_0, arg_16_1)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._rewardItems) do
		gohelper.destroy(iter_17_1.itemIcon.go)
		gohelper.destroy(iter_17_1.parentGo)
		iter_17_1.itemIcon:onDestroy()
	end

	arg_17_0._rewardItems = nil

	arg_17_0._simagebg:UnLoadImage()
	arg_17_0._simagegetallbg:UnLoadImage()
end

function var_0_0.getAnimator(arg_18_0)
	return arg_18_0._animator
end

return var_0_0
