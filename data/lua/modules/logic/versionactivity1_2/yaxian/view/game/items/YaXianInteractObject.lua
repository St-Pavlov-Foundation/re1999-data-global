module("modules.logic.versionactivity1_2.yaxian.view.game.items.YaXianInteractObject", package.seeall)

local var_0_0 = class("YaXianInteractObject", UserDataDispose)
local var_0_1 = {
	[YaXianGameEnum.InteractType.Player] = YaXianInteractPlayerHandle,
	[YaXianGameEnum.InteractType.TriggerFail] = YaXianInteractTriggerFailHandle
}
local var_0_2 = {
	[YaXianGameEnum.InteractType.Player] = YaXianInteractPlayerStatus,
	[YaXianGameEnum.InteractType.Enemy] = YaXianInteractEnemyStatus
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.delete = false
	arg_1_0.interactContainerTr = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.interactMo = arg_2_1

	local var_2_0 = YaXianConfig.instance:getInteractObjectCo(arg_2_0.interactMo.actId, arg_2_0.id)

	if var_2_0 then
		arg_2_0.config = var_2_0
		arg_2_0.handler = (var_0_1[var_2_0.interactType] or YaXianInteractHandleBase).New()

		arg_2_0.handler:init(arg_2_0)
	else
		logError("can't find interact_object : " .. tostring(arg_2_1.actId) .. ", " .. tostring(arg_2_1.id))
	end

	arg_2_0:createSceneNode()
end

function var_0_0.createSceneNode(arg_3_0)
	arg_3_0.interactItemContainerGo = UnityEngine.GameObject.New("interact_item")
	arg_3_0.interactItemContainerTr = arg_3_0.interactItemContainerGo.transform

	arg_3_0.interactItemContainerTr:SetParent(arg_3_0.interactContainerTr, false)
end

function var_0_0.loadAvatar(arg_4_0)
	if arg_4_0.loader then
		return
	end

	local var_4_0 = arg_4_0:getAvatarPath()

	if arg_4_0:isExitInteract() then
		arg_4_0.loader = MultiAbLoader.New()

		arg_4_0.loader:addPath(YaXianGameEnum.SceneResPath.ExitDefaultPath)

		if not string.nilorempty(var_4_0) then
			arg_4_0.loader:addPath(var_4_0)
		end

		arg_4_0.loader:startLoad(arg_4_0.onSceneObjectMultiLoadFinish, arg_4_0)

		return
	end

	arg_4_0.loader = PrefabInstantiate.Create(arg_4_0.interactItemContainerGo)

	if not string.nilorempty(var_4_0) then
		arg_4_0.loader:startLoad(var_4_0, arg_4_0.onSceneObjectLoadFinish, arg_4_0)
	end
end

function var_0_0.onSceneObjectLoadFinish(arg_5_0)
	arg_5_0.interactGo = arg_5_0.loader:getInstGO()

	arg_5_0:initInteractGo()
	arg_5_0:getHandler():onAvatarLoaded()
	gohelper.setLayer(arg_5_0.interactItemContainerGo, UnityLayer.Scene, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractLoadDone, arg_5_0.id)
end

function var_0_0.onSceneObjectMultiLoadFinish(arg_6_0)
	local var_6_0 = arg_6_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.ExitDefaultPath):GetResource()

	arg_6_0.defaultExitInteractGo = gohelper.clone(var_6_0, arg_6_0.interactItemContainerGo, "default")
	arg_6_0.goEnd = gohelper.findChild(arg_6_0.defaultExitInteractGo, "#go_end")
	arg_6_0.goTxtEnd = gohelper.findChild(arg_6_0.defaultExitInteractGo, "#go_end/#go_txtend")
	arg_6_0.transformEnd = arg_6_0.goEnd and arg_6_0.goEnd.transform

	local var_6_1 = arg_6_0:getAvatarPath()

	if not string.nilorempty(var_6_1) then
		local var_6_2 = arg_6_0.loader:getAssetItem(var_6_1):GetResource()

		arg_6_0.interactGo = gohelper.clone(var_6_2, arg_6_0.interactItemContainerGo)

		arg_6_0:initInteractGo()
	end

	arg_6_0:getHandler():onAvatarLoaded()
	gohelper.setLayer(arg_6_0.interactItemContainerGo, UnityLayer.Scene, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractLoadDone, arg_6_0.id)
end

function var_0_0.initInteractGo(arg_7_0)
	arg_7_0.interactGo.name = arg_7_0.id
	arg_7_0.interactAnimator = ZProj.ProjAnimatorPlayer.Get(arg_7_0.interactGo)

	arg_7_0:stopAnimation()
	arg_7_0:initDirectionNode()

	arg_7_0.iconGoContainer = gohelper.findChild(arg_7_0.interactGo, "icon")
	arg_7_0.effectGoContainer = gohelper.findChild(arg_7_0.interactGo, "skill")

	local var_7_0 = var_0_2[arg_7_0.config.interactType]

	if var_7_0 then
		arg_7_0.status = var_7_0.New()

		arg_7_0.status:init(arg_7_0)
	end

	arg_7_0.effectMgr = YaXianInteractEffect.New()

	arg_7_0.effectMgr:init(arg_7_0)

	arg_7_0.goTop = gohelper.findChild(arg_7_0.interactGo, "tou")
	arg_7_0.transformTop = not gohelper.isNil(arg_7_0.goTop) and arg_7_0.goTop.transform or nil
end

function var_0_0.updateInteractPos(arg_8_0)
	if arg_8_0.delete then
		return
	end

	local var_8_0, var_8_1, var_8_2 = YaXianGameHelper.calcTilePosInScene(arg_8_0.interactMo.posX, arg_8_0.interactMo.posY)

	transformhelper.setLocalPos(arg_8_0.interactItemContainerTr, var_8_0, var_8_1, var_8_2)
end

function var_0_0.updateInteractMo(arg_9_0, arg_9_1)
	arg_9_0.interactMo = arg_9_1

	arg_9_0:updateInteractDirection()
	arg_9_0:updateInteractPos()
end

function var_0_0.getShowPriority(arg_10_0)
	return YaXianGameEnum.InteractShowPriority[arg_10_0.config.interactType] or YaXianGameEnum.MinShowPriority
end

function var_0_0.updateActiveByShowPriority(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.interactGo, arg_11_1 <= arg_11_0:getShowPriority())

	if arg_11_0:isExitInteract() then
		if arg_11_1 > arg_11_0:getShowPriority() then
			gohelper.setActive(arg_11_0.goEnd, false)

			return
		end

		gohelper.setActive(arg_11_0.goEnd, true)
		gohelper.setActive(arg_11_0.goTxtEnd, not arg_11_0.interactGo)

		if arg_11_0.interactGo then
			if not gohelper.isNil(arg_11_0.transformEnd) then
				transformhelper.setLocalPosXY(arg_11_0.transformEnd, 0, arg_11_0.transformTop and arg_11_0.transformTop.localPosition.y or 0.5)
			else
				logError("transformEnd is nil, interact name : " .. tostring(arg_11_0.config and arg_11_0.config.name or "nil"))
			end
		elseif not gohelper.isNil(arg_11_0.transformEnd) then
			transformhelper.setLocalPosXY(arg_11_0.transformEnd, 0, 0)
		else
			logError("transformEnd is nil, interact name : " .. tostring(arg_11_0.config and arg_11_0.config.name or "nil"))
		end
	end
end

function var_0_0.updateInteractDirection(arg_12_0)
	arg_12_0:getHandler():faceTo(arg_12_0.interactMo.direction)
end

function var_0_0.setActive(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0.interactItemContainerGo, arg_13_1)
end

function var_0_0.deleteSelf(arg_14_0)
	arg_14_0.delete = true

	gohelper.setActive(arg_14_0.interactItemContainerGo, false)
end

function var_0_0.renewSelf(arg_15_0)
	arg_15_0.delete = false

	gohelper.setActive(arg_15_0.interactItemContainerGo, true)
	arg_15_0:_stopAnimation()
end

function var_0_0.isDelete(arg_16_0)
	return arg_16_0.delete
end

function var_0_0.getAvatarPath(arg_17_0)
	if arg_17_0.config and not string.nilorempty(arg_17_0.config.avatar) then
		return "scenes/" .. arg_17_0.config.avatar
	end

	return nil
end

function var_0_0.initDirectionNode(arg_18_0)
	arg_18_0.directionAvatarDict = arg_18_0:getUserDataTb_()
	arg_18_0.directionAvatarDict[YaXianGameEnum.MoveDirection.Bottom] = gohelper.findChild(arg_18_0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Bottom)
	arg_18_0.directionAvatarDict[YaXianGameEnum.MoveDirection.Left] = gohelper.findChild(arg_18_0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Left)
	arg_18_0.directionAvatarDict[YaXianGameEnum.MoveDirection.Right] = gohelper.findChild(arg_18_0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Right)
	arg_18_0.directionAvatarDict[YaXianGameEnum.MoveDirection.Top] = gohelper.findChild(arg_18_0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Top)
end

function var_0_0.getHandler(arg_19_0)
	return arg_19_0.handler
end

function var_0_0.getSelectPriority(arg_20_0)
	local var_20_0

	if arg_20_0.config then
		var_20_0 = YaXianGameEnum.InteractSelectPriority[arg_20_0.config.interactType]
	end

	return var_20_0 or arg_20_0.id
end

function var_0_0.isFighting(arg_21_0)
	if arg_21_0.config.alertType ~= YaXianGameEnum.AlertType.FourWay then
		return false
	end

	return arg_21_0.interactMo.alertPosList and next(arg_21_0.interactMo.alertPosList)
end

function var_0_0.isEnemy(arg_22_0)
	return arg_22_0.config.interactType == YaXianGameEnum.InteractType.Enemy or arg_22_0.config.interactType == YaXianGameEnum.InteractType.TriggerFail
end

function var_0_0.getEffectMgr(arg_23_0)
	return arg_23_0.effectMgr
end

function var_0_0.showEffect(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0.effectMgr then
		arg_24_0.effectMgr:showEffect(arg_24_1, arg_24_2, arg_24_3)
	end
end

function var_0_0.cancelEffectTask(arg_25_0)
	if arg_25_0.effectMgr then
		arg_25_0.effectMgr:cancelTask()
	end
end

function var_0_0.isExitInteract(arg_26_0)
	return arg_26_0.config.interactType == YaXianGameEnum.InteractType.TriggerVictory
end

function var_0_0.isPlayer(arg_27_0)
	return arg_27_0.config.interactType == YaXianGameEnum.InteractType.Player
end

function var_0_0.playAnimation(arg_28_0, arg_28_1)
	if arg_28_0.interactAnimator then
		arg_28_0.currentPlayAnimationName = arg_28_1

		arg_28_0.interactAnimator:Play(arg_28_1)
	end
end

function var_0_0.stopAnimation(arg_29_0)
	if string.nilorempty(arg_29_0.currentPlayAnimationName) then
		local var_29_0 = YaXianGameEnum.CloseAnimationName[arg_29_0.currentPlayAnimationName]

		if var_29_0 then
			arg_29_0.interactAnimator:Play(var_29_0, arg_29_0._stopAnimation, arg_29_0)

			return
		end
	end

	arg_29_0:_stopAnimation()
end

function var_0_0._stopAnimation(arg_30_0)
	if arg_30_0.interactAnimator then
		arg_30_0.interactAnimator:Play("idle")
	end
end

function var_0_0.dispose(arg_31_0)
	gohelper.setActive(arg_31_0.iconGoContainer, true)
	gohelper.setActive(arg_31_0.interactItemContainerGo, true)
	gohelper.destroy(arg_31_0.iconGoContainer)
	gohelper.destroy(arg_31_0.interactItemContainerGo)

	if arg_31_0.handler ~= nil then
		arg_31_0.handler:dispose()
	end

	if arg_31_0.loader then
		arg_31_0.loader:dispose()
	end

	if arg_31_0.status then
		arg_31_0.status:dispose()
	end

	if arg_31_0.effectMgr then
		arg_31_0.effectMgr:dispose()
	end

	arg_31_0:__onDispose()
end

return var_0_0
