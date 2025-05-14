module("modules.logic.chessgame.game.interact.ChessInteractPlayer", package.seeall)

local var_0_0 = class("ChessInteractPlayer", ChessInteractBase)

function var_0_0.onSelected(arg_1_0)
	ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.SelectObjWaitPos)
	arg_1_0:calCanWalkArea()

	arg_1_0._isPlayerSelected = true

	arg_1_0:refreshPlayerSelected()
end

function var_0_0.insertPosToList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = arg_2_0._target.mo.posX
	local var_2_1 = arg_2_0._target.mo.posY
	local var_2_2 = ChessGameHelper.ToDirection(var_2_0, var_2_1, arg_2_1, arg_2_2)

	if ChessGameController.instance:posCanWalk(arg_2_1, arg_2_2, var_2_2, arg_2_0._target.objType) then
		table.insert(arg_2_3, arg_2_1)
		table.insert(arg_2_4, arg_2_2)
		table.insert(arg_2_5, var_2_2)
	end
end

function var_0_0.onCancelSelect(arg_3_0)
	ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.None)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	arg_3_0._isPlayerSelected = false

	arg_3_0:refreshPlayerSelected()
end

function var_0_0.onSelectPos(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._isMoving or ChessGameController.instance.eventMgr:isPlayingFlow() then
		return
	end

	local var_4_0 = arg_4_0._target.mo.posX
	local var_4_1 = arg_4_0._target.mo.posY
	local var_4_2 = ChessGameHelper.ToDirection(var_4_0, var_4_1, arg_4_1, arg_4_2)

	if (var_4_0 == arg_4_1 and math.abs(var_4_1 - arg_4_2) == 1 or var_4_1 == arg_4_2 and math.abs(var_4_0 - arg_4_1) == 1) and ChessGameController.instance:posCanWalk(arg_4_1, arg_4_2, var_4_2, arg_4_0._target.objType) then
		if ChessGameController.instance:getClickStatus() ~= ChessGameEnum.SelectPosStatus.CatchObj then
			local var_4_3 = {
				param = "",
				type = ChessGameEnum.OptType.Single,
				id = arg_4_0._target.mo.id,
				direction = ChessGameHelper.ToDirection(var_4_0, var_4_1, arg_4_1, arg_4_2)
			}

			ChessGameModel.instance:appendOpt(var_4_3)

			local var_4_4 = ChessModel.instance:getActId()
			local var_4_5 = ChessModel.instance:getEpisodeId()
			local var_4_6 = ChessGameModel.instance:getOptList()

			ChessRpcController.instance:sendActBeginRoundRequest(var_4_4, var_4_5, var_4_6, arg_4_0.onMoveSuccess, arg_4_0)
			ChessGameController.instance:saveTempSelectObj()
			ChessGameController.instance:setSelectObj(nil)
		end
	else
		local var_4_7 = ChessGameController.instance:getPosCanClickInteract(arg_4_1, arg_4_2)

		if var_4_7 and (var_4_0 == arg_4_1 and math.abs(var_4_1 - arg_4_2) == 1 or var_4_1 == arg_4_2 and math.abs(var_4_0 - arg_4_1) == 1) then
			if var_4_7.config and var_4_7.config.interactType ~= ChessGameEnum.InteractType.Role then
				if var_4_7.config.canMove and (ChessGameController.instance:getClickStatus() ~= ChessGameEnum.SelectPosStatus.CatchObj or true) then
					AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_activity_box_push)
					ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.CatchObj)
					ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
						visible = false
					})
					ChessGameModel.instance:setCatchObj(var_4_7)
					var_4_7:getHandler():withCatch()

					local var_4_8, var_4_9 = var_4_7.mo:getXY()
					local var_4_10 = ChessGameHelper.ToDirection(var_4_0, var_4_1, var_4_8, var_4_9)
					local var_4_11 = (arg_4_0._target.mo.posX + var_4_8) / 2
					local var_4_12 = (arg_4_0._target.mo.posY + var_4_9) / 2

					arg_4_0:moveTo(var_4_11, var_4_12, arg_4_0._refreshNodeArea, arg_4_0)
					arg_4_0:faceTo(var_4_10)

					return
				end

				if not var_4_7.config.touchTrigger then
					return
				end

				if var_4_7.config.triggerDir == 0 or var_4_7.config.triggerDir == var_4_2 then
					if ChessGameInteractModel.instance:checkInteractFinish(var_4_7.mo.id) then
						return
					end

					local var_4_13, var_4_14 = var_4_7.mo:getXY()
					local var_4_15 = ChessGameHelper.ToDirection(var_4_0, var_4_1, var_4_13, var_4_14)

					arg_4_0:faceTo(var_4_15)

					local var_4_16 = (arg_4_0._target.mo.posX + var_4_13) / 2
					local var_4_17 = (arg_4_0._target.mo.posY + var_4_14) / 2

					local function var_4_18()
						arg_4_0._isMoving = false

						arg_4_0:moveTo(arg_4_0._target.mo.posX, arg_4_0._target.mo.posY, arg_4_0.calCanWalkArea, arg_4_0)
					end

					arg_4_0:moveTo(var_4_16, var_4_17, var_4_18, arg_4_0)
					arg_4_0:optItem(var_4_7)
				end
			else
				ChessGameController.instance:setSelectObj(nil)

				return true
			end
		else
			return
		end
	end
end

function var_0_0.optItem(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = {
		param = "",
		type = ChessGameEnum.OptType.UseItem,
		id = arg_6_1.config.id,
		direction = arg_6_1.config.triggerDir
	}

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_molu_monster_awake)
	ChessGameModel.instance:appendOpt(var_6_0)

	local var_6_1 = ChessModel.instance:getActId()
	local var_6_2 = ChessModel.instance:getEpisodeId()
	local var_6_3 = ChessGameModel.instance:getOptList()

	ChessRpcController.instance:sendActBeginRoundRequest(var_6_1, var_6_2, var_6_3, arg_6_0.onOptSuccess, arg_6_0)
	ChessGameController.instance:saveTempSelectObj()
	ChessGameController.instance:setSelectObj(nil)
end

function var_0_0.onMoveBegin(arg_7_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function var_0_0.onMoveSuccess(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	ChessGameController.instance:setSelectObj(nil)
end

function var_0_0.onOptSuccess(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 ~= 0 then
		return
	end
end

function var_0_0.calCanWalkArea(arg_10_0)
	if ChessGameModel.instance:isTalking() then
		return
	end

	local var_10_0 = arg_10_0._target.mo.posX
	local var_10_1 = arg_10_0._target.mo.posY
	local var_10_2 = {
		visible = true,
		posXList = {},
		posYList = {},
		dirList = {},
		selfPosX = var_10_0,
		selfPosY = var_10_1,
		selectType = ChessGameEnum.ChessSelectType.Normal
	}

	arg_10_0:insertPosToList(var_10_0 + 1, var_10_1, var_10_2.posXList, var_10_2.posYList, var_10_2.dirList)
	arg_10_0:insertPosToList(var_10_0 - 1, var_10_1, var_10_2.posXList, var_10_2.posYList, var_10_2.dirList)
	arg_10_0:insertPosToList(var_10_0, var_10_1 + 1, var_10_2.posXList, var_10_2.posYList, var_10_2.dirList)
	arg_10_0:insertPosToList(var_10_0, var_10_1 - 1, var_10_2.posXList, var_10_2.posYList, var_10_2.dirList)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, var_10_2)
end

function var_0_0.moveTo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	var_0_0.super.moveTo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)

	if arg_11_0._animSelf then
		arg_11_0._animSelf:Play("jump", 0, 0)
	end
end

function var_0_0.showHitAni(arg_12_0)
	if arg_12_0._animSelf then
		arg_12_0._animSelf:Play("hit", 0, 0)
	end
end

function var_0_0.refreshPlayerSelected(arg_13_0)
	return
end

function var_0_0._refreshNodeArea(arg_14_0)
	local var_14_0 = arg_14_0._target.mo.posX
	local var_14_1 = arg_14_0._target.mo.posY
	local var_14_2 = {
		visible = true,
		posXList = {},
		posYList = {},
		dirList = {},
		selfPosX = var_14_0,
		selfPosY = var_14_1,
		selectType = ChessGameEnum.ChessSelectType.CatchObj
	}
	local var_14_3 = ChessGameModel.instance:getCatchObj()

	if not var_14_3 then
		return
	end

	local var_14_4, var_14_5 = var_14_3.mo:getXY()

	var_14_2.selfPosX = var_14_4
	var_14_2.selfPosY = var_14_5

	local var_14_6
	local var_14_7

	ChessGameModel.instance:cleanCatchObjCanWalkList()

	if var_14_0 == var_14_4 then
		local var_14_8 = {
			x = var_14_0,
			y = math.max(var_14_1, var_14_5) + 1
		}

		if arg_14_0:catchObjCanWalk(var_14_8) then
			table.insert(var_14_2.posXList, var_14_4)
			table.insert(var_14_2.posYList, var_14_5 + 1)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Up)

			local var_14_9 = {
				x = var_14_4,
				y = var_14_5 + 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_9)
		end

		local var_14_10 = {
			x = var_14_0,
			y = math.min(var_14_1, var_14_5) - 1
		}

		if arg_14_0:catchObjCanWalk(var_14_10) then
			table.insert(var_14_2.posXList, var_14_4)
			table.insert(var_14_2.posYList, var_14_5 - 1)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Down)

			local var_14_11 = {
				x = var_14_4,
				y = var_14_5 - 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_11)
		end

		local var_14_12 = {
			x = var_14_0 - 1,
			y = var_14_1
		}
		local var_14_13 = {
			x = var_14_4 - 1,
			y = var_14_5
		}

		if arg_14_0:catchObjCanWalk(var_14_12, var_14_13) then
			table.insert(var_14_2.posXList, var_14_4 - 1)
			table.insert(var_14_2.posYList, var_14_5)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Left)

			local var_14_14 = {
				x = var_14_4 - 1,
				y = var_14_5
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_14)
		end

		local var_14_15 = {
			x = var_14_0 + 1,
			y = var_14_1
		}
		local var_14_16 = {
			x = var_14_4 + 1,
			y = var_14_5
		}

		if arg_14_0:catchObjCanWalk(var_14_15, var_14_16) then
			table.insert(var_14_2.posXList, var_14_4 + 1)
			table.insert(var_14_2.posYList, var_14_5)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Right)

			local var_14_17 = {
				x = var_14_4 + 1,
				y = var_14_5
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_17)
		end
	else
		local var_14_18 = {
			x = var_14_0,
			y = var_14_1 + 1
		}
		local var_14_19 = {
			x = var_14_4,
			y = var_14_5 + 1
		}

		if arg_14_0:catchObjCanWalk(var_14_18, var_14_19) then
			table.insert(var_14_2.posXList, var_14_4)
			table.insert(var_14_2.posYList, var_14_5 + 1)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Up)

			local var_14_20 = {
				x = var_14_4,
				y = var_14_5 + 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_20)
		end

		local var_14_21 = {
			x = var_14_0,
			y = var_14_1 - 1
		}
		local var_14_22 = {
			x = var_14_4,
			y = var_14_5 - 1
		}

		if arg_14_0:catchObjCanWalk(var_14_21, var_14_22) then
			table.insert(var_14_2.posXList, var_14_4)
			table.insert(var_14_2.posYList, var_14_5 - 1)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Down)

			local var_14_23 = {
				x = var_14_4,
				y = var_14_5 - 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_23)
		end

		local var_14_24 = {
			x = math.min(var_14_0, var_14_4) - 1,
			y = var_14_1
		}

		if arg_14_0:catchObjCanWalk(var_14_24) then
			table.insert(var_14_2.posXList, var_14_4 - 1)
			table.insert(var_14_2.posYList, var_14_5)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Left)

			local var_14_25 = {
				x = var_14_4 - 1,
				y = var_14_5
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_25)
		end

		local var_14_26 = {
			x = math.max(var_14_0, var_14_4) + 1,
			y = var_14_1
		}

		if arg_14_0:catchObjCanWalk(var_14_26) then
			table.insert(var_14_2.posXList, var_14_4 + 1)
			table.insert(var_14_2.posYList, var_14_5)
			table.insert(var_14_2.dirList, ChessGameEnum.Direction.Right)

			local var_14_27 = {
				x = var_14_4 + 1,
				y = var_14_5
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(var_14_27)
		end
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, var_14_2)
end

function var_0_0.catchObjCanWalk(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 and not ChessGameController.instance:posCanWalk(arg_15_1.x, arg_15_1.y) then
		return false
	end

	if arg_15_2 and not ChessGameController.instance:posCanWalk(arg_15_2.x, arg_15_2.y) then
		return false
	end

	return true
end

function var_0_0.onSetPosWithCatchObj(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {
		x = arg_16_1,
		y = arg_16_2
	}

	if not ChessGameModel.instance:checkPosCatchObjCanWalk(var_16_0) then
		arg_16_0:cancelCatchObj(true)

		return
	end

	local var_16_1 = ChessGameModel.instance:getCatchObj()

	if not var_16_1 then
		return
	end

	local var_16_2, var_16_3 = var_16_1.mo:getXY()
	local var_16_4 = {
		type = ChessGameEnum.OptType.WithInteract,
		id = arg_16_0._target.mo.id,
		direction = ChessGameHelper.ToDirection(var_16_2, var_16_3, arg_16_1, arg_16_2),
		param = tostring(var_16_1.mo.id)
	}

	ChessGameModel.instance:appendOpt(var_16_4)

	local var_16_5 = ChessModel.instance:getActId()
	local var_16_6 = ChessModel.instance:getEpisodeId()
	local var_16_7 = ChessGameModel.instance:getOptList()

	ChessRpcController.instance:sendActBeginRoundRequest(var_16_5, var_16_6, var_16_7, arg_16_0.onMoveSuccess, arg_16_0)
	ChessGameController.instance:saveTempSelectObj()
	ChessGameController.instance:setSelectObj(nil)
end

function var_0_0.cancelCatchObj(arg_17_0, arg_17_1)
	if arg_17_1 then
		ChessGameModel.instance:setCatchObj(nil)
		ChessGameModel.instance:cleanCatchObjCanWalkList()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
			visible = false
		})
		arg_17_0:moveTo(arg_17_0._target.mo.posX, arg_17_0._target.mo.posY, arg_17_0.onSelected, arg_17_0)
	end
end

function var_0_0.onAvatarLoaded(arg_18_0)
	var_0_0.super.onAvatarLoaded(arg_18_0)

	local var_18_0 = arg_18_0._target.avatar.loader

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0:getInstGO()

	if not gohelper.isNil(var_18_1) then
		arg_18_0._animSelf = var_18_1:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_18_0._target.avatar.goSelected = gohelper.findChild(var_18_0:getInstGO(), "piecea/vx_select")

	gohelper.setActive(arg_18_0._target.avatar.goSelected, true)
	arg_18_0:refreshPlayerSelected()
end

return var_0_0
