module("modules.logic.rouge.map.controller.RougeMapInteractHelper", package.seeall)

local var_0_0 = class("RougeMapInteractHelper")

function var_0_0.triggerInteractive()
	local var_1_0 = RougeMapModel.instance:getCurInteractive()

	if string.nilorempty(var_1_0) then
		return
	end

	local var_1_1 = string.splitToNumber(var_1_0, "#")
	local var_1_2 = var_1_1[1]
	local var_1_3 = var_1_1[2]

	var_0_0._initInteractHandle()

	local var_1_4 = var_0_0.handleDict[var_1_2]

	if not var_1_4 then
		logError("not found interact type .. " .. tostring(var_1_2))

		return
	end

	var_1_4(var_1_3)
end

function var_0_0._initInteractHandle()
	if not var_0_0.handleDict then
		var_0_0.handleDict = {
			[RougeMapEnum.InteractType.Drop] = var_0_0.handleDrop,
			[RougeMapEnum.InteractType.LossCollection] = var_0_0.handleLoss,
			[RougeMapEnum.InteractType.ReturnBlood] = var_0_0.handleReturnBlood,
			[RougeMapEnum.InteractType.Resurgence] = var_0_0.handleResurgence,
			[RougeMapEnum.InteractType.Recruit] = var_0_0.handleRecruit,
			[RougeMapEnum.InteractType.DropGroup] = var_0_0.handleDropGroup,
			[RougeMapEnum.InteractType.LossAndCopy] = var_0_0.handleLossAndCopy,
			[RougeMapEnum.InteractType.LossAssignCollection] = var_0_0.handleLossAssignCollection,
			[RougeMapEnum.InteractType.LossNotUniqueCollection] = var_0_0.handleLossNotUniqueCollection,
			[RougeMapEnum.InteractType.StorageCollection] = var_0_0.handleStorageCollection,
			[RougeMapEnum.InteractType.LossCoin] = var_0_0.handleLossCoin,
			[RougeMapEnum.InteractType.AdvanceDrop] = var_0_0.handleAdvanceDrop,
			[RougeMapEnum.InteractType.LevelUpSp] = var_0_0.handleLevelUpSpCollection,
			[RougeMapEnum.InteractType.LossSpCollection] = var_0_0.handleLossSpCollection,
			[RougeMapEnum.InteractType.DropBossCollection] = var_0_0.handleDropBossCollection
		}
	end
end

function var_0_0.handleDrop(arg_3_0)
	logWarn("触发掉落")

	local var_3_0 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = var_3_0.dropCollectList,
		canSelectCount = var_3_0.dropSelectNum,
		dropRandomNum = var_3_0.dropRandomNum
	})
end

function var_0_0.handleLoss()
	logWarn("触发丢弃")

	local var_4_0 = RougeMapModel.instance:getCurInteractiveJson()
	local var_4_1 = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Abandon,
		lostNum = var_4_0.lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(var_4_1)
	})
end

function var_0_0.handleReturnBlood()
	logWarn("触发回血")

	local var_5_0 = RougeMapModel.instance:getCurInteractiveJson()
	local var_5_1 = RougeController.instance:createTeamViewParam(var_5_0.healNum, var_0_0.onSelectReturnBloodHero)

	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeTeamView, RougeController.openRougeTeamTreatView, RougeController.instance, var_5_1)
end

function var_0_0.onSelectReturnBloodHero(arg_6_0, arg_6_1)
	if not arg_6_1 or #arg_6_1 == 0 then
		return
	end

	RougeRpc.instance:sendRougeSelectHealRequest(arg_6_1)
end

function var_0_0.handleRecruit()
	logWarn("触发招募")
	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeHeroGroupEditView, RougeController.openSelectHero, RougeController.instance, var_0_0._selectHeroHandler)
end

function var_0_0._selectHeroHandler(arg_8_0, arg_8_1)
	if not arg_8_1 or #arg_8_1 == 0 then
		RougeRpc.instance:sendRougeRecruitHeroRequest(nil)

		return
	end

	RougeRpc.instance:sendRougeRecruitHeroRequest(arg_8_1)
end

function var_0_0.handleResurgence()
	logWarn("触发复活")

	local var_9_0 = RougeMapModel.instance:getCurInteractiveJson()
	local var_9_1 = RougeController.instance:createTeamViewParam(var_9_0.reviveNum, var_0_0.onSelectReviveHero)

	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeTeamView, RougeController.openRougeTeamReviveView, RougeController.instance, var_9_1)
end

function var_0_0.onSelectReviveHero(arg_10_0, arg_10_1)
	if not arg_10_1 or #arg_10_1 == 0 then
		return
	end

	RougeRpc.instance:sendRougeSelectReviveRequest(arg_10_1)
end

function var_0_0.handleDropGroup()
	logWarn("触发掉落组")

	local var_11_0 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = var_11_0.dropCollectList,
		canSelectCount = var_11_0.dropSelectNum,
		dropRandomNum = var_11_0.dropRandomNum
	})
end

function var_0_0.handleLossAndCopy()
	logNormal("损失造物并复制")

	local var_12_0 = RougeMapModel.instance:getCurInteractiveJson()
	local var_12_1 = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Copy,
		lostNum = var_12_0.lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(var_12_1)
	})
end

function var_0_0.handleLossAssignCollection()
	logNormal("损失指定造物")
end

function var_0_0.handleLossNotUniqueCollection()
	logNormal("损失非唯一造物")

	local var_14_0 = RougeMapModel.instance:getCurInteractiveJson()
	local var_14_1 = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Copy,
		lostNum = var_14_0.lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(var_14_1)
	})
end

function var_0_0.handleStorageCollection()
	logNormal("存储造物")

	local var_15_0 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionStorageView, {
		lossCount = var_15_0.lostNum
	})
end

function var_0_0.handleLossCoin()
	logNormal("损失金币")
end

function var_0_0.handleAdvanceDrop(arg_17_0)
	logNormal("高级掉落")

	local var_17_0 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = var_17_0.dropCollectList,
		canSelectCount = var_17_0.dropSelectNum,
		dropRandomNum = var_17_0.dropRandomNum
	})
end

function var_0_0.handleLevelUpSpCollection()
	logNormal("专武升级")

	local var_18_0 = RougeMapModel.instance:getCurInteractiveJson()
	local var_18_1 = RougeMapModel.instance:getCurInteractType()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionLevelUpView, {
		closeBtnVisible = false,
		maxLevelUpNum = var_18_0.collectionLevelUpNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(var_18_1)
	})
end

function var_0_0.handleLossSpCollection(arg_19_0)
	if arg_19_0 == 1 then
		logNormal("丢弃专武")

		local var_19_0 = RougeMapModel.instance:getCurInteractiveJson()
		local var_19_1 = RougeMapModel.instance:getCurInteractType()
		local var_19_2 = RougeDLCModel102.instance:getAllSpCollections()

		RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
			lossType = RougeMapEnum.LossType.AbandonSp,
			lostNum = var_19_0.lostNum,
			filterUnique = RougeMapHelper.checkNeedFilterUnique(var_19_1),
			collections = var_19_2
		})
	elseif arg_19_0 == 2 then
		logNormal("获得丢弃专武")
	end
end

function var_0_0.handleDropBossCollection()
	logNormal("选附带怪物属性的造物")

	local var_20_0 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeBossCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		canSelectCount = var_20_0.dropSelectNum,
		collectionList = var_20_0.dropCollectList,
		monsterRuleList = var_20_0.dropCollectMonsterRuleList
	})
end

return var_0_0
