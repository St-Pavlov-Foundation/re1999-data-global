module("modules.logic.sp01.odyssey.view.OdysseyDungeonRewardView", package.seeall)

local var_0_0 = class("OdysseyDungeonRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gotaskFinish = gohelper.findChild(arg_1_0.viewGO, "root/#go_taskFinish")
	arg_1_0._gotxtContent = gohelper.findChild(arg_1_0.viewGO, "root/#go_taskFinish/#go_txtContent")
	arg_1_0._goexpItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_taskFinish/#go_txtContent/#go_expItem")
	arg_1_0._txtexp = gohelper.findChildText(arg_1_0.viewGO, "root/#go_taskFinish/#go_txtContent/#go_expItem/#txt_exp")
	arg_1_0._gotalentItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_taskFinish/#go_txtContent/#go_talentItem")
	arg_1_0._txttalentItem = gohelper.findChildText(arg_1_0.viewGO, "root/#go_taskFinish/#go_txtContent/#go_talentItem/#txt_talentItem")
	arg_1_0._goitemContent = gohelper.findChild(arg_1_0.viewGO, "root/#go_taskFinish/#go_txtContent/#go_itemContent")
	arg_1_0._goitemIcon = gohelper.findChild(arg_1_0.viewGO, "root/#go_taskFinish/#go_txtContent/#go_itemContent/#go_itemIcon")
	arg_1_0._golevelUp = gohelper.findChild(arg_1_0.viewGO, "root/#go_levelUp")
	arg_1_0._txtcurLevel = gohelper.findChildText(arg_1_0.viewGO, "root/#go_levelUp/curLevel/#txt_curLevel")
	arg_1_0._txtlevelupTalentItem = gohelper.findChildText(arg_1_0.viewGO, "root/#go_levelUp/levelupTalentItem/#txt_levelupTalentItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	if not arg_4_0.isAllShowFinish then
		if arg_4_0.rewardShowFlow then
			local var_4_0 = arg_4_0.rewardShowFlow:getWorkList()[arg_4_0.rewardShowFlow._curIndex]

			if var_4_0 then
				var_4_0:onSetDone()
			end
		end

		return
	else
		arg_4_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.rewardItemTab = arg_5_0:getUserDataTb_()
	arg_5_0.rewardOuterItemTab = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._goitemIcon, false)
	gohelper.setActive(arg_5_0._gotaskFinish, false)
	gohelper.setActive(arg_5_0._golevelUp, false)

	arg_5_0.showTime = 2
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_receive_award)
	arg_7_0:initShowRewardData()
	arg_7_0:showContent()
end

function var_0_0.initShowRewardData(arg_8_0)
	arg_8_0.showAddItemList = {}

	local var_8_0 = arg_8_0.viewParam.showAddItemList

	arg_8_0.showAddOuterItemList = arg_8_0.viewParam.showAddOuterItemList or {}
	arg_8_0.heroCurLevel = arg_8_0.viewParam.heroCurLevel
	arg_8_0.heroCurExp = arg_8_0.viewParam.heroCurExp
	arg_8_0.heroOldLevel = arg_8_0.viewParam.heroOldLevel
	arg_8_0.levelAddTalentPoint = arg_8_0.viewParam.levelAddTalentPoint
	arg_8_0.rewardAddTalentPoint = arg_8_0.viewParam.rewardAddTalentPoint
	arg_8_0.addExp = arg_8_0.viewParam.addExp

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1.addCount > 0 then
			table.insert(arg_8_0.showAddItemList, iter_8_1)
		end
	end
end

function var_0_0.showContent(arg_9_0)
	arg_9_0:refreshTxtContent()
	arg_9_0:refreshItemContent()
	arg_9_0:refreshLevelUpContent()

	local var_9_0

	arg_9_0.rewardShowFlow = FlowSequence.New()

	if arg_9_0.addExp > 0 or arg_9_0.rewardAddTalentPoint > 0 or #arg_9_0.showAddItemList > 0 or #arg_9_0.showAddOuterItemList > 0 then
		if arg_9_0.rewardAddTalentPoint > 0 then
			var_9_0 = OdysseyEnum.RewardItemType.Talent
		end

		local var_9_1 = #arg_9_0.showAddItemList > 0 or #arg_9_0.showAddOuterItemList > 0

		arg_9_0.rewardShowFlow:addWork(OdysseyShowRewardWork.New(arg_9_0._gotaskFinish, 2, var_9_0, var_9_1))
		TaskDispatcher.cancelTask(arg_9_0.showAddExpEffect, arg_9_0)
		TaskDispatcher.runDelay(arg_9_0.showAddExpEffect, arg_9_0, 0.5)
	end

	if arg_9_0.heroCurLevel ~= arg_9_0.heroOldLevel then
		local var_9_2 = OdysseyEnum.RewardItemType.Talent

		arg_9_0.rewardShowFlow:addWork(OdysseyShowRewardWork.New(arg_9_0._golevelUp, 1.5, var_9_2))
	end

	arg_9_0.rewardShowFlow:registerDoneListener(arg_9_0.allShowFinish, arg_9_0)
	arg_9_0.rewardShowFlow:start()
end

function var_0_0.showAddExpEffect(arg_10_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowAddExpEffect)
end

function var_0_0.refreshTxtContent(arg_11_0)
	gohelper.setActive(arg_11_0._goexpItem, arg_11_0.addExp > 0)

	arg_11_0._txtexp.text = arg_11_0.addExp > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_reward_getexp"), arg_11_0.addExp) or ""

	gohelper.setActive(arg_11_0._gotalentItem, arg_11_0.rewardAddTalentPoint > 0)

	arg_11_0._txttalentItem.text = arg_11_0.rewardAddTalentPoint > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_reward_gettalent"), arg_11_0.rewardAddTalentPoint) or ""
end

function var_0_0.refreshItemContent(arg_12_0)
	local var_12_0 = {}

	tabletool.addValues(var_12_0, arg_12_0.showAddOuterItemList)
	tabletool.addValues(var_12_0, arg_12_0.showAddItemList)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0.rewardItemTab[iter_12_0]

		if not var_12_1 then
			var_12_1 = {
				go = gohelper.clone(arg_12_0._goitemIcon, arg_12_0._goitemContent, "rewardItem_" .. iter_12_0)
			}
			var_12_1.itemGO = arg_12_0.viewContainer:getResInst(arg_12_0.viewContainer:getSetting().otherRes[1], var_12_1.go)
			var_12_1.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1.itemGO, OdysseyItemIcon)
			arg_12_0.rewardItemTab[iter_12_0] = var_12_1
		end

		if iter_12_1.itemType == OdysseyEnum.RewardItemType.OuterItem then
			local var_12_2 = {
				type = tonumber(iter_12_1.type),
				id = tonumber(iter_12_1.id)
			}

			var_12_1.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, var_12_2, tonumber(iter_12_1.addCount))
		else
			var_12_1.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.Item, tonumber(iter_12_1.id), tonumber(iter_12_1.addCount))
		end

		gohelper.setActive(var_12_1.go, true)
	end
end

function var_0_0.refreshLevelUpContent(arg_13_0)
	arg_13_0._txtcurLevel.text = arg_13_0.heroCurLevel
	arg_13_0._txtlevelupTalentItem.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_reward_gettalent"), arg_13_0.levelAddTalentPoint)
end

function var_0_0.allShowFinish(arg_14_0)
	arg_14_0.isAllShowFinish = true

	arg_14_0:closeThis()
end

function var_0_0.onClose(arg_15_0)
	OdysseyItemModel.instance:cleanAllAddCount()
	OdysseyTalentModel.instance:cleanChangeTalentPoint()

	if arg_15_0.heroCurLevel ~= arg_15_0.heroOldLevel then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnRefreshHeroLevel)
	end

	OdysseyModel.instance:updateHeroOldLevel(arg_15_0.heroCurLevel, arg_15_0.heroCurExp)
	TaskDispatcher.cancelTask(arg_15_0.showAddExpEffect, arg_15_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnCloseDungeonRewardView)
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0.rewardShowFlow then
		arg_16_0.rewardShowFlow:destroy()

		arg_16_0.rewardShowFlow = nil
	end
end

return var_0_0
