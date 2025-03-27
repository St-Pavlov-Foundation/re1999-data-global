module("modules.logic.rouge.map.controller.RougeMapInteractHelper", package.seeall)

slot0 = class("RougeMapInteractHelper")

function slot0.triggerInteractive()
	if string.nilorempty(RougeMapModel.instance:getCurInteractive()) then
		return
	end

	slot1 = string.splitToNumber(slot0, "#")
	slot3 = slot1[2]

	uv0._initInteractHandle()

	if not uv0.handleDict[slot1[1]] then
		logError("not found interact type .. " .. tostring(slot2))

		return
	end

	slot4(slot3)
end

function slot0._initInteractHandle()
	if not uv0.handleDict then
		uv0.handleDict = {
			[RougeMapEnum.InteractType.Drop] = uv0.handleDrop,
			[RougeMapEnum.InteractType.LossCollection] = uv0.handleLoss,
			[RougeMapEnum.InteractType.ReturnBlood] = uv0.handleReturnBlood,
			[RougeMapEnum.InteractType.Resurgence] = uv0.handleResurgence,
			[RougeMapEnum.InteractType.Recruit] = uv0.handleRecruit,
			[RougeMapEnum.InteractType.DropGroup] = uv0.handleDropGroup,
			[RougeMapEnum.InteractType.LossAndCopy] = uv0.handleLossAndCopy,
			[RougeMapEnum.InteractType.LossAssignCollection] = uv0.handleLossAssignCollection,
			[RougeMapEnum.InteractType.LossNotUniqueCollection] = uv0.handleLossNotUniqueCollection,
			[RougeMapEnum.InteractType.StorageCollection] = uv0.handleStorageCollection,
			[RougeMapEnum.InteractType.LossCoin] = uv0.handleLossCoin,
			[RougeMapEnum.InteractType.AdvanceDrop] = uv0.handleAdvanceDrop,
			[RougeMapEnum.InteractType.LevelUpSp] = uv0.handleLevelUpSpCollection,
			[RougeMapEnum.InteractType.LossSpCollection] = uv0.handleLossSpCollection
		}
	end
end

function slot0.handleDrop(slot0)
	logWarn("触发掉落")

	slot1 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = slot1.dropCollectList,
		canSelectCount = slot1.dropSelectNum,
		dropRandomNum = slot1.dropRandomNum
	})
end

function slot0.handleLoss()
	logWarn("触发丢弃")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Abandon,
		lostNum = RougeMapModel.instance:getCurInteractiveJson().lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(RougeMapModel.instance:getCurInteractType())
	})
end

function slot0.handleReturnBlood()
	logWarn("触发回血")
	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeTeamView, RougeController.openRougeTeamTreatView, RougeController.instance, RougeController.instance:createTeamViewParam(RougeMapModel.instance:getCurInteractiveJson().healNum, uv0.onSelectReturnBloodHero))
end

function slot0.onSelectReturnBloodHero(slot0, slot1)
	if not slot1 or #slot1 == 0 then
		return
	end

	RougeRpc.instance:sendRougeSelectHealRequest(slot1)
end

function slot0.handleRecruit()
	logWarn("触发招募")
	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeHeroGroupEditView, RougeController.openSelectHero, RougeController.instance, uv0._selectHeroHandler)
end

function slot0._selectHeroHandler(slot0, slot1)
	if not slot1 or #slot1 == 0 then
		RougeRpc.instance:sendRougeRecruitHeroRequest(nil)

		return
	end

	RougeRpc.instance:sendRougeRecruitHeroRequest(slot1)
end

function slot0.handleResurgence()
	logWarn("触发复活")
	RougePopController.instance:addPopViewWithOpenFunc(ViewName.RougeTeamView, RougeController.openRougeTeamReviveView, RougeController.instance, RougeController.instance:createTeamViewParam(RougeMapModel.instance:getCurInteractiveJson().reviveNum, uv0.onSelectReviveHero))
end

function slot0.onSelectReviveHero(slot0, slot1)
	if not slot1 or #slot1 == 0 then
		return
	end

	RougeRpc.instance:sendRougeSelectReviveRequest(slot1)
end

function slot0.handleDropGroup()
	logWarn("触发掉落组")

	slot0 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = slot0.dropCollectList,
		canSelectCount = slot0.dropSelectNum,
		dropRandomNum = slot0.dropRandomNum
	})
end

function slot0.handleLossAndCopy()
	logNormal("损失造物并复制")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Copy,
		lostNum = RougeMapModel.instance:getCurInteractiveJson().lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(RougeMapModel.instance:getCurInteractType())
	})
end

function slot0.handleLossAssignCollection()
	logNormal("损失指定造物")
end

function slot0.handleLossNotUniqueCollection()
	logNormal("损失非唯一造物")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
		lossType = RougeMapEnum.LossType.Copy,
		lostNum = RougeMapModel.instance:getCurInteractiveJson().lostNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(RougeMapModel.instance:getCurInteractType())
	})
end

function slot0.handleStorageCollection()
	logNormal("存储造物")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionStorageView, {
		lossCount = RougeMapModel.instance:getCurInteractiveJson().lostNum
	})
end

function slot0.handleLossCoin()
	logNormal("损失金币")
end

function slot0.handleAdvanceDrop(slot0)
	logNormal("高级掉落")

	slot1 = RougeMapModel.instance:getCurInteractiveJson()

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		viewEnum = RougeMapEnum.CollectionDropViewEnum.Select,
		collectionList = slot1.dropCollectList,
		canSelectCount = slot1.dropSelectNum,
		dropRandomNum = slot1.dropRandomNum
	})
end

function slot0.handleLevelUpSpCollection()
	logNormal("专武升级")
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionLevelUpView, {
		closeBtnVisible = false,
		maxLevelUpNum = RougeMapModel.instance:getCurInteractiveJson().collectionLevelUpNum,
		filterUnique = RougeMapHelper.checkNeedFilterUnique(RougeMapModel.instance:getCurInteractType())
	})
end

function slot0.handleLossSpCollection(slot0)
	if slot0 == 1 then
		logNormal("丢弃专武")
		RougePopController.instance:addPopViewWithViewName(ViewName.RougeMapCollectionAbandonView, {
			lossType = RougeMapEnum.LossType.AbandonSp,
			lostNum = RougeMapModel.instance:getCurInteractiveJson().lostNum,
			filterUnique = RougeMapHelper.checkNeedFilterUnique(RougeMapModel.instance:getCurInteractType()),
			collections = RougeDLCModel102.instance:getAllSpCollections()
		})
	elseif slot0 == 2 then
		logNormal("获得丢弃专武")
	end
end

return slot0
