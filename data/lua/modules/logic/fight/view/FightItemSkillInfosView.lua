module("modules.logic.fight.view.FightItemSkillInfosView", package.seeall)

local var_0_0 = class("FightItemSkillInfosView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_panel/simage_wheel/go_itemLayout/go_skillitem")

	arg_1_0.itemObjList = {}

	for iter_1_0 = 1, 8 do
		local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_panel/simage_wheel/go_itemLayout/" .. iter_1_0)
		local var_1_2 = gohelper.clone(var_1_0, var_1_1, "item")

		recthelper.setAnchor(var_1_2.transform, 0, 0)
		table.insert(arg_1_0.itemObjList, var_1_2)
	end

	gohelper.setActive(var_1_0, false)

	arg_1_0.arrowObj = gohelper.findChild(arg_1_0.viewGO, "Root/#go_panel/simage_wheel/arrow")
	arg_1_0.arrowTransform = gohelper.findChild(arg_1_0.viewGO, "Root/#go_panel/simage_wheel/arrow/select").transform
	arg_1_0.click = gohelper.findChildClick(arg_1_0.viewGO, "Root/#go_panel/simage_wheel/#btn_select")
	arg_1_0.closeClick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "Root/#go_panel/#btn_close")
	arg_1_0.itemName = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_panel/Image_skillBG/#txt_skillTitle")
	arg_1_0.itemDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_panel/Image_skillBG/#txt_skillDec")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.tweenComp = arg_2_0:addComponent(FightTweenComponent)

	arg_2_0:com_registClick(arg_2_0.click, arg_2_0.onClick)
	arg_2_0:com_registClick(arg_2_0.closeClick, arg_2_0.closeThis)
	arg_2_0:com_registFightEvent(FightEvent.StageChanged, arg_2_0.onStageChanged)
	arg_2_0:com_registFightEvent(FightEvent.RespUseClothSkillFail, arg_2_0.onRespUseClothSkillFail)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onStageChanged(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onRespUseClothSkillFail(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClick(arg_6_0)
	if not arg_6_0.selectData then
		return
	end

	if arg_6_0.selectData.cd > 0 then
		GameFacade.showToast(ToastEnum.Season123RefreshAssistInCD)

		return
	end

	if arg_6_0.selectData.count <= 0 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	gohelper.setActive(arg_6_0.arrowObj, false)

	for iter_6_0 = 1, #arg_6_0.itemObjList do
		local var_6_0 = arg_6_0.itemObjList[iter_6_0]

		gohelper.setActive(var_6_0, iter_6_0 == arg_6_0.selectIndex)
	end

	local var_6_1 = arg_6_0:com_registFlowSequence()
	local var_6_2 = var_6_1:registWork(FightWorkFlowParallel)
	local var_6_3 = arg_6_0.itemObjList[arg_6_0.selectIndex].transform
	local var_6_4, var_6_5 = recthelper.getAnchor(var_6_3.parent)
	local var_6_6 = EaseType.OutQuart
	local var_6_7 = {
		type = "DOAnchorPos",
		t = 0.2,
		tr = arg_6_0.itemObjList[arg_6_0.selectIndex].transform,
		tox = -var_6_4,
		toy = -var_6_5,
		ease = var_6_6
	}

	var_6_2:registWork(FightTweenWork, var_6_7)
	var_6_2:registWork(FightWorkPlayAnimator, arg_6_0.viewGO, "close")

	local var_6_8 = {
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		t = 0.2,
		go = var_6_3.gameObject
	}

	var_6_1:registWork(FightTweenWork, var_6_8)
	var_6_1:registWork(FightWorkFunction, arg_6_0.sendMsg, arg_6_0)
	var_6_1:start()
	AudioMgr.instance:trigger(20305003)
end

function var_0_0.sendMsg(arg_7_0)
	FightRpc.instance:sendUseClothSkillRequest(arg_7_0.selectData.skillId, "0", FightDataHelper.operationDataMgr.curSelectEntityId, FightEnum.ClothSkillType.AssassinBigSkill)
end

function var_0_0.onItemClick(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.selectData == arg_8_1 then
		arg_8_0:onClick()

		return
	end

	arg_8_0.selectData = arg_8_1
	arg_8_0.selectIndex = arg_8_2

	local var_8_0 = lua_skill.configDict[arg_8_1.skillId]
	local var_8_1 = lua_assassin_item.configDict[arg_8_1.itemId]

	arg_8_0.itemName.text = var_8_1.name

	local var_8_2 = HeroSkillModel.instance:skillDesToSpot(var_8_1.fightEffDesc, "#c56131", "#7c93ad")

	arg_8_0.itemDesc.text = var_8_2

	local var_8_3 = arg_8_0.itemObjList[arg_8_2].transform.parent.localPosition.normalized
	local var_8_4 = Mathf.Atan2(var_8_3.y, var_8_3.x) * Mathf.Rad2Deg - 180
	local var_8_5 = 0.35
	local var_8_6 = EaseType.OutQuart

	arg_8_0.tweenComp:DOLocalRotate(arg_8_0.arrowTransform, 0, 0, var_8_4, var_8_5, nil, nil, nil, var_8_6)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList) do
		iter_8_1:onSelect(iter_8_0 == arg_8_2)
	end

	AudioMgr.instance:trigger(20305002)
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(20305001)

	arg_9_0.itemList = {}

	local var_9_0 = FightDataHelper.teamDataMgr.myData.itemSkillInfos

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.itemId < arg_10_1.itemId
	end)

	for iter_9_0 = 1, #arg_9_0.itemObjList do
		local var_9_1 = arg_9_0.itemObjList[iter_9_0]
		local var_9_2 = var_9_0[iter_9_0]

		if var_9_2 then
			local var_9_3 = arg_9_0:com_openSubView(FightItemSkillInfosItemView, var_9_1, nil, var_9_2, iter_9_0)

			table.insert(arg_9_0.itemList, var_9_3)
		else
			gohelper.setActive(var_9_1, false)
		end
	end

	local var_9_4 = false

	for iter_9_1 = 1, #var_9_0 do
		local var_9_5 = var_9_0[iter_9_1]

		if var_9_5.cd <= 0 and var_9_5.count > 0 then
			arg_9_0.itemList[iter_9_1]:onClick()

			var_9_4 = true

			break
		end
	end

	if not var_9_4 then
		arg_9_0.itemList[1]:onClick()
	end

	AudioMgr.instance:trigger(20305002)
end

return var_0_0
