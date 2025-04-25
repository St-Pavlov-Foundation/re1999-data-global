module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessMallItem", package.seeall)

slot0 = class("AutoChessMallItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.mallView = slot1
end

function slot0.setPos(slot0, slot1, slot2)
	slot0.startX = slot1
	slot0.startY = slot2

	recthelper.setAnchor(slot0.transform, slot1, slot2)
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.transform = slot1.transform
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "")
	slot0.imageBg = gohelper.findChildImage(slot1, "bg")
	slot0.goEntity = gohelper.findChild(slot1, "Entity")
	slot0.goMesh = gohelper.findChild(slot1, "Entity/Mesh")
	slot0.goCost = gohelper.findChild(slot1, "cost")
	slot0.txtCost = gohelper.findChildText(slot1, "cost/txt_Cost")
	slot0.imageCost = gohelper.findChildImage(slot1, "cost/image_Cost")
	slot0.goAttack = gohelper.findChild(slot1, "go_Attack")
	slot0.txtAttack = gohelper.findChildText(slot1, "go_Attack/txt_Attack")
	slot0.goHp = gohelper.findChild(slot1, "go_Hp")
	slot0.txtHp = gohelper.findChildText(slot1, "go_Hp/txt_Hp")
	slot0.goLock = gohelper.findChild(slot1, "go_Lock")
	slot0.imageTag = gohelper.findChildImage(slot1, "image_Tag")
	slot0.golvup = gohelper.findChild(slot1, "go_lvup")

	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
	CommonDragHelper.instance:registerDragObj(slot0.go, slot0._beginDrag, slot0._onDrag, slot0._endDrag, slot0._checkDrag, slot0, nil, true)

	slot0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goMesh, AutoChessMeshComp)
	slot0.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goEntity, AutoChessEffectComp)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.StartBuyStepFinih, slot0.refreshLvup, slot0)
end

function slot0.onDestroy(slot0)
	CommonDragHelper.instance:unregisterDragObj(slot0.go)

	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.mallId = slot1
	slot0.isFree = slot3

	if slot2 then
		slot0.data = slot2
		slot4 = false

		if slot0.isFree then
			slot0.txtCost.text = 0
		else
			slot5, slot6 = AutoChessConfig.instance:getItemBuyCost(slot2.id)

			UISpriteSetMgr.instance:setAutoChessSprite(slot0.imageCost, "v2a5_autochess_cost" .. slot5)

			if AutoChessModel.instance:getChessMo().svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(slot0.data.chess.battle) and AutoChessHelper.isPrimeNumber(slot0.data.chess.hp) then
				slot6 = slot6 - 1
			end

			slot0.txtCost.text = slot6
			slot4 = slot6 ~= 3
		end

		gohelper.setActive(slot0.goCost, not slot0.isFree and slot4)

		slot5 = slot2.chess
		slot0.config = lua_auto_chess.configDict[slot5.id][slot5.star]

		if slot0.config then
			slot0.meshComp:setData(slot0.config.image)
			slot0:initBuffEffect()

			if slot0.config.type == AutoChessStrEnum.ChessType.Support then
				UISpriteSetMgr.instance:setAutoChessSprite(slot0.imageBg, "v2a5_autochess_quality2_" .. slot0.config.levelFromMall)
				gohelper.setActive(slot0.goAttack, false)
				gohelper.setActive(slot0.goHp, false)
			else
				UISpriteSetMgr.instance:setAutoChessSprite(slot0.imageBg, "v2a5_autochess_quality1_" .. slot0.config.levelFromMall)

				slot0.txtAttack.text = slot5.battle
				slot0.txtHp.text = slot5.hp

				gohelper.setActive(slot0.goAttack, true)
				gohelper.setActive(slot0.goHp, true)
			end

			if lua_auto_chess_translate.configDict[slot0.config.race] then
				UISpriteSetMgr.instance:setAutoChessSprite(slot0.imageTag, slot6.tagResName)
				gohelper.setActive(slot0.imageTag, true)
			else
				gohelper.setActive(slot0.imageTag, false)
			end

			slot0:refreshLvup()
		else
			logError(string.format("异常:不存在棋子配置ID:%s星级:%s", slot5.id, slot5.star))
		end

		slot0:setLock(slot2.freeze)
	end

	gohelper.setActive(slot0.go, slot2)
end

function slot0.setLock(slot0, slot1)
	gohelper.setActive(slot0.goLock, slot1)
end

function slot0.onClick(slot0)
	if slot0.isDraging then
		return
	end

	AutoChessController.instance:openCardInfoView({
		mall = slot0.isFree and slot0.mallView.freeMall or slot0.mallView.chargeMall,
		itemUId = slot0.data.uid
	})
end

function slot0._checkDrag(slot0)
	return false
end

function slot0._beginDrag(slot0)
	slot0.isDraging = true

	gohelper.setAsLastSibling(slot0.go)
	gohelper.setActive(slot0.imageBg, false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.DrageMallItem, slot0.config.id, tonumber(slot0.txtCost.text))
end

function slot0._onDrag(slot0, slot1, slot2)
	slot6, slot7 = recthelper.getAnchor(slot0.transform)

	if math.abs(slot6 - recthelper.screenPosToAnchorPos(slot2.position, slot0.transform.parent).x) > 10 or math.abs(slot7 - slot4.y) > 10 then
		slot0:forceEndAnim()

		slot0.tweenId = ZProj.TweenHelper.DOAnchorPos(slot5, slot4.x, slot4.y, 0.2)
	else
		recthelper.setAnchor(slot5, slot4.x, slot4.y)
	end
end

function slot0.forceEndAnim(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0._endDrag(slot0, slot1, slot2)
	slot0:forceEndAnim()

	slot0.isDraging = false

	slot0:checkBuy(slot2.position)
	gohelper.setActive(slot0.imageBg, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.DrageMallItemEnd)
end

function slot0.checkBuy(slot0, slot1)
	slot2 = recthelper.screenPosToAnchorPos(slot1, slot0.mallView.viewGO.transform)
	slot3, slot4 = AutoChessGameModel.instance:getNearestTileXY(slot2.x, slot2.y)

	if slot3 and AutoChessController.instance:isRowIndexEnable(slot3) then
		slot6, slot7 = AutoChessConfig.instance:getItemBuyCost(slot0.data.id)

		if AutoChessModel.instance:getChessMo().svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(slot0.data.chess.battle) and AutoChessHelper.isPrimeNumber(slot0.data.chess.hp) then
			slot7 = slot7 - 1
		end

		if not slot0.isFree and not slot5:checkCostEnough(slot6, slot7) then
			ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)
			GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)

			return
		end

		if tonumber(slot5:getChessPosition(slot3, slot4).chess.uid) == 0 then
			if slot0.config.type == AutoChessStrEnum.ChessType.Attack and slot3 == AutoChessEnum.WarZone.Two or slot0.config.type == AutoChessStrEnum.ChessType.Support and slot3 ~= AutoChessEnum.WarZone.Two then
				GameFacade.showToast(ToastEnum.AutoChessBuyWarZoneError)
				ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)

				return
			else
				AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
			end

			if slot0.isFree and AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableDragFreeChess) then
				ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)

				return
			end

			if not slot0.isFree and AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableDragChess) then
				ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)

				return
			end
		else
			if not AutoChessHelper.hasUniversalBuff(slot0.data.chess.buffContainer.buffs) and (slot0.config.type == AutoChessStrEnum.ChessType.Attack and slot3 == AutoChessEnum.WarZone.Two or slot0.config.type == AutoChessStrEnum.ChessType.Support and slot3 ~= AutoChessEnum.WarZone.Two) then
				GameFacade.showToast(ToastEnum.AutoChessBuyWarZoneError)
				ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)

				return
			end

			slot11 = string.format("%s_%s", slot8.chess.exp, slot0.data.chess.exp)

			if slot8.chess.id == slot0.data.chess.id or slot9 then
				slot12 = slot8.chess

				if slot12.exp == slot12.maxExpLimit then
					GameFacade.showToast(ToastEnum.AutoChessExpMax)
					ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)

					return
				elseif AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableExchangeEXP, slot11) then
					ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)

					return
				else
					AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDragChessExchangeEXP)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
				end
			else
				GameFacade.showToast(ToastEnum.AutoChessBuyTargetError)
				ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)

				return
			end
		end

		gohelper.setActive(slot0.go, false)
		recthelper.setAnchor(slot0.transform, slot0.startX, slot0.startY)
		AutoChessRpc.instance:sendAutoChessBuyChessRequest(AutoChessModel.instance:getCurModuleId(), slot0.mallId, slot0.data.uid, slot3, slot4 - 1)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZBuyChess, slot0.data.chess.id)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDrayChessToPos, string.format("%d_%d", slot0.data.chess.id, slot3))

		if slot0.isFree then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDragFreeChess)
		end
	else
		ZProj.TweenHelper.DOAnchorPos(slot0.transform, slot0.startX, slot0.startY, 0.2)
	end
end

function slot0.initBuffEffect(slot0)
	slot0.effectComp:hideAll()

	for slot4, slot5 in ipairs(slot0.data.chess.buffContainer.buffs) do
		if lua_auto_chess_buff.configDict[slot5.id].buffeffectID ~= 0 and lua_auto_chess_effect.configDict[slot6].loop == 1 then
			slot0.effectComp:playEffect(slot7.id)
		end
	end

	if not string.nilorempty(slot0.config.tag) then
		slot0.effectComp:playEffect(AutoChessStrEnum.Tag2EffectId[slot1])
	end
end

function slot0.refreshLvup(slot0)
	if not slot0.config then
		return
	end

	if AutoChessModel.instance:getChessMo().svrFight:hasUpgradeableChess(slot0.config.id) then
		gohelper.setActive(slot0.golvup, true)
	else
		gohelper.setActive(slot0.golvup, false)
	end
end

return slot0
