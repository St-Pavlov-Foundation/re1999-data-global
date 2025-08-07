module("modules.logic.sp01.odyssey.view.OdysseyLevelRewardItem", package.seeall)

local var_0_0 = class("OdysseyLevelRewardItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLock = gohelper.findChild(arg_1_0.viewGO, "title/go_lock")
	arg_1_0._txtLockLevel = gohelper.findChildText(arg_1_0.viewGO, "title/go_lock/txt_lockLevel")
	arg_1_0._goHasGet = gohelper.findChild(arg_1_0.viewGO, "title/go_hasget")
	arg_1_0._txtHasGetLevel = gohelper.findChildText(arg_1_0.viewGO, "title/go_hasget/txt_hasgetLevel")
	arg_1_0._goCanGet = gohelper.findChild(arg_1_0.viewGO, "title/go_canget")
	arg_1_0._txtCanGetLevel = gohelper.findChildText(arg_1_0.viewGO, "title/go_canget/txt_cangetLevel")
	arg_1_0._goRewardContent = gohelper.findChild(arg_1_0.viewGO, "go_rewardContent")
	arg_1_0._goRewardItem = gohelper.findChild(arg_1_0.viewGO, "go_rewardContent/go_rewardItem")
	arg_1_0._goLine = gohelper.findChild(arg_1_0.viewGO, "go_line")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onRewardItemClick(arg_4_0, arg_4_1)
	if arg_4_0.isCanGet then
		local var_4_0 = OdysseyTaskModel.instance:getAllCanGetIdList(OdysseyEnum.TaskType.LevelReward)

		if #var_4_0 > 1 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Odyssey, 0, var_4_0, nil, nil, 0)
		else
			TaskRpc.instance:sendFinishTaskRequest(arg_4_0.taskId)
		end
	else
		MaterialTipController.instance:showMaterialInfo(arg_4_1.rewardData[1], arg_4_1.rewardData[2])
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.rewardItemTab = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._goRewardItem, false)

	arg_5_0.taskList = OdysseyTaskModel.instance:getCurTaskList(OdysseyEnum.TaskType.LevelReward)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return
	end

	arg_6_0.mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0.taskId = arg_7_0.mo.id
	arg_7_0.config = arg_7_0.mo.config
	arg_7_0.level = arg_7_0.config.maxProgress

	gohelper.setActive(arg_7_0.viewGO, true)

	arg_7_0._txtLockLevel.text = "LV." .. arg_7_0.level
	arg_7_0._txtHasGetLevel.text = "LV." .. arg_7_0.level
	arg_7_0._txtCanGetLevel.text = "LV." .. arg_7_0.level

	gohelper.setActive(arg_7_0._goLine, arg_7_0.taskId ~= arg_7_0.taskList[#arg_7_0.taskList].id)
	arg_7_0:refreshReward()
end

function var_0_0.refreshReward(arg_8_0)
	arg_8_0.isHasGet = OdysseyTaskModel.instance:isTaskHasGet(arg_8_0.mo)
	arg_8_0.isCanGet = OdysseyTaskModel.instance:isTaskCanGet(arg_8_0.mo)

	local var_8_0 = arg_8_0.mo.config
	local var_8_1 = GameUtil.splitString2(var_8_0.bonus, true)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = arg_8_0.rewardItemTab[iter_8_0]

		if not var_8_2 then
			var_8_2 = {
				go = gohelper.clone(arg_8_0._goRewardItem, arg_8_0._goRewardContent, "rewardItem_" .. iter_8_0)
			}
			var_8_2.imageRare = gohelper.findChildImage(var_8_2.go, "image_rare")
			var_8_2.simageReward = gohelper.findChildSingleImage(var_8_2.go, "simage_reward")
			var_8_2.goCanGet = gohelper.findChild(var_8_2.go, "go_canget")
			var_8_2.goHasGet = gohelper.findChild(var_8_2.go, "go_hasget")
			var_8_2.txtRewardCount = gohelper.findChildText(var_8_2.go, "mask/txt_rewardcount")
			var_8_2.txtRewardCountGrey = gohelper.findChildText(var_8_2.go, "mask/txt_rewardcount_grey")
			var_8_2.btnClick = gohelper.findChildButton(var_8_2.go, "btn_click")

			var_8_2.btnClick:AddClickListener(arg_8_0.onRewardItemClick, arg_8_0, var_8_2)

			arg_8_0.rewardItemTab[iter_8_0] = var_8_2
		end

		var_8_2.rewardData = iter_8_1
		var_8_2.config, var_8_2.icon = ItemModel.instance:getItemConfigAndIcon(iter_8_1[1], iter_8_1[2], true)

		gohelper.setActive(var_8_2.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(var_8_2.imageRare, "bg_pinjidi_" .. tostring(var_8_2.config.rare), nil)

		if var_8_2.config.subType == ItemEnum.SubType.Portrait then
			var_8_2.simageReward:LoadImage(ResUrl.getPlayerHeadIcon(var_8_2.config.icon), function()
				ZProj.UGUIHelper.SetImageSize(var_8_2.simageReward.gameObject)
			end)
		else
			var_8_2.simageReward:LoadImage(var_8_2.icon, function()
				ZProj.UGUIHelper.SetImageSize(var_8_2.simageReward.gameObject)
			end)
		end

		var_8_2.txtRewardCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), iter_8_1[3])
		var_8_2.txtRewardCountGrey.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), iter_8_1[3])

		gohelper.setActive(var_8_2.goHasGet, arg_8_0.isHasGet)
		gohelper.setActive(var_8_2.goCanGet, arg_8_0.isCanGet)
		gohelper.setActive(var_8_2.txtRewardCount, not arg_8_0.isHasGet)
		gohelper.setActive(var_8_2.txtRewardCountGrey, arg_8_0.isHasGet)
	end

	for iter_8_2 = #var_8_1 + 1, #arg_8_0.rewardItemTab do
		local var_8_3 = arg_8_0.rewardItemTab[iter_8_2]

		if var_8_3 then
			gohelper.setActive(var_8_3.itemIcon.go, false)
		end
	end

	gohelper.setActive(arg_8_0._goLock, not arg_8_0.isCanGet and not arg_8_0.isHasGet)
	gohelper.setActive(arg_8_0._goHasGet, arg_8_0.isHasGet)
	gohelper.setActive(arg_8_0._goCanGet, arg_8_0.isCanGet)
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0.rewardItemTab then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.rewardItemTab) do
			iter_11_1.simageReward:UnLoadImage()
			iter_11_1.btnClick:RemoveClickListener()
		end

		arg_11_0.rewardItemTab = nil
	end
end

return var_0_0
