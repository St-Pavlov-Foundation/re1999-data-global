module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractStatusBase", package.seeall)

slot0 = class("YaXianInteractStatusBase", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()
end

function slot0.init(slot0, slot1)
	slot0.interactItem = slot1
	slot0.interactMo = slot1.interactMo
	slot0.iconGoContainer = slot1.iconGoContainer
	slot0.config = slot0.interactMo.config

	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, slot0.onUpdateEffectInfo, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.RefreshInteractStatus, slot0.refreshStatus, slot0)
end

function slot0.onUpdateEffectInfo(slot0)
	slot0:refreshStatus(slot0.isShow)
end

function slot0.refreshStatus(slot0, slot1)
	slot0:stopLoopSwitchAnimation()

	slot0.isShow = slot1

	if not slot1 then
		gohelper.setActive(slot0.iconGo, false)

		return
	end

	if not slot0.iconGo then
		slot0:loadIconPrefab()

		return
	end

	if not YaXianGameController.instance:isSelectingPlayer() then
		gohelper.setActive(slot0.iconGo, false)

		return
	end

	slot0:updateStatus()

	slot2 = slot0:hasStatus()

	gohelper.setActive(slot0.iconGo, slot2)

	if slot2 then
		slot0:startStatusAnimation()
	end
end

function slot0.updateStatus(slot0)
	slot0.statusDict = {}
end

function slot0.addStatus(slot0, slot1, slot2)
	if not slot0.statusDict[slot1] then
		slot0.statusDict[slot1] = YaXianGameController.instance:getInteractStatusPool():getObject()
	end

	slot3:addStatus(slot1, slot2)
end

function slot0.hasStatus(slot0)
	return slot0.statusDict and next(slot0.statusDict)
end

function slot0.loadIconPrefab(slot0)
	if slot0.iconLoader then
		return
	end

	slot0.iconLoader = PrefabInstantiate.Create(slot0.iconGoContainer)

	slot0.iconLoader:startLoad(YaXianGameEnum.SceneResPath.MonsterStatus, slot0.onIconLoadCallback, slot0)
end

function slot0.onIconLoadCallback(slot0)
	slot0.iconGo = slot0.iconLoader:getInstGO()
	slot0.statusGoDict = slot0:getUserDataTb_()
	slot0.statusGoDict[YaXianGameEnum.IconStatus.Assassinate] = gohelper.findChild(slot0.iconGo, "ansha")
	slot0.statusGoDict[YaXianGameEnum.IconStatus.Fight] = gohelper.findChild(slot0.iconGo, "zhandou")
	slot0.statusGoDict[YaXianGameEnum.IconStatus.InVisible] = gohelper.findChild(slot0.iconGo, "yingsheng")
	slot0.statusGoDict[YaXianGameEnum.IconStatus.ThroughWall] = gohelper.findChild(slot0.iconGo, "chuanqiang")
	slot4 = slot0.iconGo
	slot5 = "dead"
	slot0.statusGoDict[YaXianGameEnum.IconStatus.PlayerAssassinate] = gohelper.findChild(slot4, slot5)
	slot0.statusAnimatorDict = slot0:getUserDataTb_()
	slot0.statusDirectionDict = {}

	for slot4, slot5 in pairs(slot0.statusGoDict) do
		slot0.statusAnimatorDict[slot4] = slot5:GetComponent(typeof(UnityEngine.Animator))

		if YaXianGameEnum.DirectionIcon[slot4] then
			slot0.statusDirectionDict[slot4] = slot0:getUserDataTb_()

			for slot9, slot10 in pairs(YaXianGameEnum.MoveDirection) do
				slot0.statusDirectionDict[slot4][slot10] = gohelper.findChild(slot5, YaXianGameEnum.DirectionName[slot10])
			end
		end
	end

	slot0:refreshStatus(slot0.isShow)
end

function slot0.startStatusAnimation(slot0)
	if not slot0.statusDict then
		gohelper.setActive(slot0.iconGo, false)

		return
	end

	slot0.statusLen = tabletool.len(slot0.statusDict)

	if slot0.statusLen <= 0 then
		gohelper.setActive(slot0.iconGo, false)

		return
	end

	gohelper.setActive(slot0.iconGo, true)

	if slot0.statusLen == 1 then
		for slot4, slot5 in pairs(slot0.statusDict) do
			slot0:showOneStatusIcon(slot4)
		end

		return
	end

	slot0.statusList = {}

	for slot4, slot5 in pairs(slot0.statusDict) do
		table.insert(slot0.statusList, slot4)
	end

	slot0.currentShowStatusIndex = 0

	slot0:startLoopSwitchAnimation()
end

function slot0.showOneStatusIcon(slot0, slot1)
	for slot5, slot6 in pairs(slot0.statusGoDict) do
		gohelper.setActive(slot6, false)
	end

	gohelper.setActive(slot0.statusGoDict[slot1], true)

	if YaXianGameEnum.DirectionIcon[slot1] then
		slot2 = slot0.statusDict[slot1]

		for slot6, slot7 in pairs(slot0.statusDirectionDict[slot1]) do
			gohelper.setActive(slot7, false)
		end

		if slot2.directionList then
			for slot6, slot7 in pairs(slot2.directionList) do
				gohelper.setActive(slot0.statusDirectionDict[slot1][slot7], true)
			end
		end
	end
end

function slot0.stopStatusAnimation(slot0)
	slot0:stopLoopSwitchAnimation()
	gohelper.setActive(slot0.iconGo, false)

	if slot0.statusDict then
		for slot4, slot5 in pairs(slot0.statusDict) do
			YaXianGameController.instance:getInteractStatusPool():putObject(slot5)
		end
	end

	slot0.statusDict = nil
	slot0.statusList = nil
end

function slot0.startLoopSwitchAnimation(slot0)
	slot0.flow = FlowSequence.New()

	if slot0.currentShowStatusIndex > 0 then
		slot0.flow:addWork(DelayFuncWork.New(slot0.playIconCloseAnimation, slot0, YaXianGameEnum.IconAnimationDuration, slot0.statusAnimatorDict[slot0.statusList[slot1]]))
	end

	slot0.currentShowStatusIndex = slot0.currentShowStatusIndex + 1

	if slot0.statusLen < slot0.currentShowStatusIndex then
		slot0.currentShowStatusIndex = 1
	end

	slot0.flow:addWork(DelayFuncWork.New(slot0.playIconOpenAnimation, slot0, YaXianGameEnum.IconAnimationDuration, slot0.statusAnimatorDict[slot0.statusList[slot0.currentShowStatusIndex]]))
	slot0.flow:registerDoneListener(slot0.onSwitchAnimationDone, slot0)
	slot0.flow:start()
end

function slot0.playIconCloseAnimation(slot0, slot1)
	slot1:Play("close")
end

function slot0.playIconOpenAnimation(slot0, slot1)
	slot0:showOneStatusIcon(slot0.statusList[slot0.currentShowStatusIndex])
	slot1:Play("open")
end

function slot0.onSwitchAnimationDone(slot0)
	TaskDispatcher.runDelay(slot0.startLoopSwitchAnimation, slot0, YaXianGameEnum.IconAnimationSwitchInterval)
end

function slot0.stopLoopSwitchAnimation(slot0)
	if slot0.flow then
		slot0.flow:destroy()
	end

	TaskDispatcher.cancelTask(slot0.startLoopSwitchAnimation, slot0)
end

function slot0.dispose(slot0)
	slot0:stopStatusAnimation()

	if slot0.iconLoader then
		slot0.iconLoader:dispose()
	end

	slot0:__onDispose()
end

return slot0
