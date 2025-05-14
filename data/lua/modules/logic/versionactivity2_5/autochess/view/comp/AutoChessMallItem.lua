module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessMallItem", package.seeall)

local var_0_0 = class("AutoChessMallItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.mallView = arg_1_1
end

function var_0_0.setPos(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.startX = arg_2_1
	arg_2_0.startY = arg_2_2

	recthelper.setAnchor(arg_2_0.transform, arg_2_1, arg_2_2)
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0.transform = arg_3_1.transform
	arg_3_0.btnClick = gohelper.findChildButtonWithAudio(arg_3_1, "")
	arg_3_0.imageBg = gohelper.findChildImage(arg_3_1, "bg")
	arg_3_0.goEntity = gohelper.findChild(arg_3_1, "Entity")
	arg_3_0.goMesh = gohelper.findChild(arg_3_1, "Entity/Mesh")
	arg_3_0.goCost = gohelper.findChild(arg_3_1, "cost")
	arg_3_0.txtCost = gohelper.findChildText(arg_3_1, "cost/txt_Cost")
	arg_3_0.imageCost = gohelper.findChildImage(arg_3_1, "cost/image_Cost")
	arg_3_0.goAttack = gohelper.findChild(arg_3_1, "go_Attack")
	arg_3_0.txtAttack = gohelper.findChildText(arg_3_1, "go_Attack/txt_Attack")
	arg_3_0.goHp = gohelper.findChild(arg_3_1, "go_Hp")
	arg_3_0.txtHp = gohelper.findChildText(arg_3_1, "go_Hp/txt_Hp")
	arg_3_0.goLock = gohelper.findChild(arg_3_1, "go_Lock")
	arg_3_0.imageTag = gohelper.findChildImage(arg_3_1, "image_Tag")
	arg_3_0.golvup = gohelper.findChild(arg_3_1, "go_lvup")

	arg_3_0:addClickCb(arg_3_0.btnClick, arg_3_0.onClick, arg_3_0)
	CommonDragHelper.instance:registerDragObj(arg_3_0.go, arg_3_0._beginDrag, arg_3_0._onDrag, arg_3_0._endDrag, arg_3_0._checkDrag, arg_3_0, nil, true)

	arg_3_0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_3_0.goMesh, AutoChessMeshComp)
	arg_3_0.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_3_0.goEntity, AutoChessEffectComp)
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(AutoChessController.instance, AutoChessEvent.StartBuyStepFinih, arg_4_0.refreshLvup, arg_4_0)
end

function var_0_0.onDestroy(arg_5_0)
	CommonDragHelper.instance:unregisterDragObj(arg_5_0.go)

	if arg_5_0.loader then
		arg_5_0.loader:dispose()

		arg_5_0.loader = nil
	end
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.mallId = arg_6_1
	arg_6_0.isFree = arg_6_3

	if arg_6_2 then
		arg_6_0.data = arg_6_2

		local var_6_0 = false

		if arg_6_0.isFree then
			arg_6_0.txtCost.text = 0
		else
			local var_6_1, var_6_2 = AutoChessConfig.instance:getItemBuyCost(arg_6_2.id)
			local var_6_3 = "v2a5_autochess_cost" .. var_6_1

			UISpriteSetMgr.instance:setAutoChessSprite(arg_6_0.imageCost, var_6_3)

			if AutoChessModel.instance:getChessMo().svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(arg_6_0.data.chess.battle) and AutoChessHelper.isPrimeNumber(arg_6_0.data.chess.hp) then
				var_6_2 = var_6_2 - 1
			end

			arg_6_0.txtCost.text = var_6_2
			var_6_0 = var_6_2 ~= 3
		end

		gohelper.setActive(arg_6_0.goCost, not arg_6_0.isFree and var_6_0)

		local var_6_4 = arg_6_2.chess

		arg_6_0.config = lua_auto_chess.configDict[var_6_4.id][var_6_4.star]

		if arg_6_0.config then
			arg_6_0.meshComp:setData(arg_6_0.config.image)
			arg_6_0:initBuffEffect()

			if arg_6_0.config.type == AutoChessStrEnum.ChessType.Support then
				UISpriteSetMgr.instance:setAutoChessSprite(arg_6_0.imageBg, "v2a5_autochess_quality2_" .. arg_6_0.config.levelFromMall)
				gohelper.setActive(arg_6_0.goAttack, false)
				gohelper.setActive(arg_6_0.goHp, false)
			else
				UISpriteSetMgr.instance:setAutoChessSprite(arg_6_0.imageBg, "v2a5_autochess_quality1_" .. arg_6_0.config.levelFromMall)

				arg_6_0.txtAttack.text = var_6_4.battle
				arg_6_0.txtHp.text = var_6_4.hp

				gohelper.setActive(arg_6_0.goAttack, true)
				gohelper.setActive(arg_6_0.goHp, true)
			end

			local var_6_5 = lua_auto_chess_translate.configDict[arg_6_0.config.race]

			if var_6_5 then
				UISpriteSetMgr.instance:setAutoChessSprite(arg_6_0.imageTag, var_6_5.tagResName)
				gohelper.setActive(arg_6_0.imageTag, true)
			else
				gohelper.setActive(arg_6_0.imageTag, false)
			end

			arg_6_0:refreshLvup()
		else
			logError(string.format("异常:不存在棋子配置ID:%s星级:%s", var_6_4.id, var_6_4.star))
		end

		arg_6_0:setLock(arg_6_2.freeze)
	end

	gohelper.setActive(arg_6_0.go, arg_6_2)
end

function var_0_0.setLock(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0.goLock, arg_7_1)
end

function var_0_0.onClick(arg_8_0)
	if arg_8_0.isDraging then
		return
	end

	local var_8_0 = arg_8_0.isFree and arg_8_0.mallView.freeMall or arg_8_0.mallView.chargeMall
	local var_8_1 = {
		mall = var_8_0,
		itemUId = arg_8_0.data.uid
	}

	AutoChessController.instance:openCardInfoView(var_8_1)
end

function var_0_0._checkDrag(arg_9_0)
	return false
end

function var_0_0._beginDrag(arg_10_0)
	arg_10_0.isDraging = true

	gohelper.setAsLastSibling(arg_10_0.go)
	gohelper.setActive(arg_10_0.imageBg, false)

	local var_10_0 = tonumber(arg_10_0.txtCost.text)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.DrageMallItem, arg_10_0.config.id, var_10_0)
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2.position
	local var_11_1 = recthelper.screenPosToAnchorPos(var_11_0, arg_11_0.transform.parent)
	local var_11_2 = arg_11_0.transform
	local var_11_3, var_11_4 = recthelper.getAnchor(var_11_2)

	if math.abs(var_11_3 - var_11_1.x) > 10 or math.abs(var_11_4 - var_11_1.y) > 10 then
		arg_11_0:forceEndAnim()

		arg_11_0.tweenId = ZProj.TweenHelper.DOAnchorPos(var_11_2, var_11_1.x, var_11_1.y, 0.2)
	else
		recthelper.setAnchor(var_11_2, var_11_1.x, var_11_1.y)
	end
end

function var_0_0.forceEndAnim(arg_12_0)
	if arg_12_0.tweenId then
		ZProj.TweenHelper.KillById(arg_12_0.tweenId)

		arg_12_0.tweenId = nil
	end
end

function var_0_0._endDrag(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:forceEndAnim()

	arg_13_0.isDraging = false

	arg_13_0:checkBuy(arg_13_2.position)
	gohelper.setActive(arg_13_0.imageBg, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.DrageMallItemEnd)
end

function var_0_0.checkBuy(arg_14_0, arg_14_1)
	local var_14_0 = recthelper.screenPosToAnchorPos(arg_14_1, arg_14_0.mallView.viewGO.transform)
	local var_14_1, var_14_2 = AutoChessGameModel.instance:getNearestTileXY(var_14_0.x, var_14_0.y)

	if var_14_1 and AutoChessController.instance:isRowIndexEnable(var_14_1) then
		local var_14_3 = AutoChessModel.instance:getChessMo()
		local var_14_4, var_14_5 = AutoChessConfig.instance:getItemBuyCost(arg_14_0.data.id)

		if var_14_3.svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(arg_14_0.data.chess.battle) and AutoChessHelper.isPrimeNumber(arg_14_0.data.chess.hp) then
			var_14_5 = var_14_5 - 1
		end

		if not arg_14_0.isFree and not var_14_3:checkCostEnough(var_14_4, var_14_5) then
			ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)
			GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)

			return
		end

		local var_14_6 = var_14_3:getChessPosition(var_14_1, var_14_2)

		if tonumber(var_14_6.chess.uid) == 0 then
			if arg_14_0.config.type == AutoChessStrEnum.ChessType.Attack and var_14_1 == AutoChessEnum.WarZone.Two or arg_14_0.config.type == AutoChessStrEnum.ChessType.Support and var_14_1 ~= AutoChessEnum.WarZone.Two then
				GameFacade.showToast(ToastEnum.AutoChessBuyWarZoneError)
				ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)

				return
			else
				AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
			end

			if arg_14_0.isFree and AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableDragFreeChess) then
				ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)

				return
			end

			if not arg_14_0.isFree and AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableDragChess) then
				ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)

				return
			end
		else
			local var_14_7 = AutoChessHelper.hasUniversalBuff(arg_14_0.data.chess.buffContainer.buffs)

			if not var_14_7 and (arg_14_0.config.type == AutoChessStrEnum.ChessType.Attack and var_14_1 == AutoChessEnum.WarZone.Two or arg_14_0.config.type == AutoChessStrEnum.ChessType.Support and var_14_1 ~= AutoChessEnum.WarZone.Two) then
				GameFacade.showToast(ToastEnum.AutoChessBuyWarZoneError)
				ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)

				return
			end

			local var_14_8 = var_14_6.chess.id
			local var_14_9 = string.format("%s_%s", var_14_6.chess.exp, arg_14_0.data.chess.exp)

			if var_14_8 == arg_14_0.data.chess.id or var_14_7 then
				local var_14_10 = var_14_6.chess

				if var_14_10.exp == var_14_10.maxExpLimit then
					GameFacade.showToast(ToastEnum.AutoChessExpMax)
					ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)

					return
				elseif AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableExchangeEXP, var_14_9) then
					ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)

					return
				else
					AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDragChessExchangeEXP)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
				end
			else
				GameFacade.showToast(ToastEnum.AutoChessBuyTargetError)
				ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)

				return
			end
		end

		gohelper.setActive(arg_14_0.go, false)
		recthelper.setAnchor(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY)

		local var_14_11 = AutoChessModel.instance:getCurModuleId()

		AutoChessRpc.instance:sendAutoChessBuyChessRequest(var_14_11, arg_14_0.mallId, arg_14_0.data.uid, var_14_1, var_14_2 - 1)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZBuyChess, arg_14_0.data.chess.id)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDrayChessToPos, string.format("%d_%d", arg_14_0.data.chess.id, var_14_1))

		if arg_14_0.isFree then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDragFreeChess)
		end
	else
		ZProj.TweenHelper.DOAnchorPos(arg_14_0.transform, arg_14_0.startX, arg_14_0.startY, 0.2)
	end
end

function var_0_0.initBuffEffect(arg_15_0)
	arg_15_0.effectComp:hideAll()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.data.chess.buffContainer.buffs) do
		local var_15_0 = lua_auto_chess_buff.configDict[iter_15_1.id].buffeffectID

		if var_15_0 ~= 0 then
			local var_15_1 = lua_auto_chess_effect.configDict[var_15_0]

			if var_15_1.loop == 1 then
				arg_15_0.effectComp:playEffect(var_15_1.id)
			end
		end
	end

	local var_15_2 = arg_15_0.config.tag

	if not string.nilorempty(var_15_2) then
		arg_15_0.effectComp:playEffect(AutoChessStrEnum.Tag2EffectId[var_15_2])
	end
end

function var_0_0.refreshLvup(arg_16_0)
	if not arg_16_0.config then
		return
	end

	if AutoChessModel.instance:getChessMo().svrFight:hasUpgradeableChess(arg_16_0.config.id) then
		gohelper.setActive(arg_16_0.golvup, true)
	else
		gohelper.setActive(arg_16_0.golvup, false)
	end
end

return var_0_0
