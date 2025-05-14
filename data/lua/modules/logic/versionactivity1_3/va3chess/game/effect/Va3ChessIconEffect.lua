module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessIconEffect", package.seeall)

local var_0_0 = class("Va3ChessIconEffect", Va3ChessEffectBase)

function var_0_0.onAvatarLoaded(arg_1_0)
	if not arg_1_0._loader then
		return
	end

	local var_1_0 = arg_1_0._loader:getInstGO()

	if not gohelper.isNil(var_1_0) then
		gohelper.setLayer(var_1_0, UnityLayer.Scene, true)

		local var_1_1 = gohelper.findChild(var_1_0, "icon_tanhao")

		arg_1_0._target.avatar.goTrack = var_1_1

		gohelper.setActive(var_1_1, false)

		local var_1_2 = gohelper.findChild(var_1_0, "icon_jianshi")

		arg_1_0._target.avatar.goTracked = var_1_2

		gohelper.setActive(var_1_2, false)

		arg_1_0.moveKillIcon = gohelper.findChild(var_1_0, "icon_kejisha")

		gohelper.setActive(arg_1_0.moveKillIcon, false)

		arg_1_0.willKillPlayerIcon = gohelper.findChild(var_1_0, "icon_yuxi")

		gohelper.setActive(arg_1_0.willKillPlayerIcon, false)

		arg_1_0.fireBallKillIcon = gohelper.findChild(var_1_0, "icon_huoyanbiaoji")

		gohelper.setActive(arg_1_0.fireBallKillIcon, false)
	end

	arg_1_0._dirPointGODict = {}
	arg_1_0._dirCanFireKillEffGODict = {}

	for iter_1_0, iter_1_1 in pairs(Va3ChessEnum.Direction) do
		local var_1_3 = arg_1_0._target.avatar["goFaceTo" .. iter_1_1]

		if not gohelper.isNil(var_1_3) then
			local var_1_4 = gohelper.findChild(var_1_3, arg_1_0._effectCfg.piontName)

			arg_1_0._dirPointGODict[iter_1_1] = var_1_4

			local var_1_5 = gohelper.findChild(var_1_3, "selected")

			arg_1_0._dirCanFireKillEffGODict[iter_1_1] = var_1_5

			gohelper.setActive(var_1_5, false)
		end
	end

	arg_1_0:refreshEffectFaceTo()
end

function var_0_0.refreshEffectFaceTo(arg_2_0)
	if not arg_2_0._dirPointGODict then
		return
	end

	local var_2_0 = arg_2_0._target.originData:getDirection()
	local var_2_1 = arg_2_0._dirPointGODict[var_2_0]

	if not gohelper.isNil(var_2_1) then
		local var_2_2, var_2_3, var_2_4 = transformhelper.getPos(var_2_1.transform)

		transformhelper.setPos(arg_2_0.effectGO.transform, var_2_2, var_2_3, var_2_4)
	end

	arg_2_0:refreshKillEffect()
end

function var_0_0.refreshKillEffect(arg_3_0)
	local var_3_0 = false
	local var_3_1 = {}

	if arg_3_0._target and arg_3_0._target.originData and arg_3_0._target.originData.data then
		var_3_1 = arg_3_0._target.originData.data.alertArea
	end

	if var_3_1 and #var_3_1 > 0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			var_3_0 = Va3ChessGameController.instance:getPlayerNextCanWalkPosDict()[Activity142Helper.getPosHashKey(iter_3_1.x, iter_3_1.y)]

			if var_3_0 then
				break
			end
		end
	end

	gohelper.setActive(arg_3_0.willKillPlayerIcon, var_3_0)

	local var_3_2 = Activity142Helper.isCanFireKill(arg_3_0._target)

	gohelper.setActive(arg_3_0.fireBallKillIcon, var_3_2)
	arg_3_0:refreshCanMoveKillEffect()
	arg_3_0:refreshCanFireBallKillEffect(var_3_2)
end

function var_0_0.refreshCanMoveKillEffect(arg_4_0)
	local var_4_0 = Activity142Helper.isCanMoveKill(arg_4_0._target)

	gohelper.setActive(arg_4_0.moveKillIcon, var_4_0)
end

function var_0_0.refreshCanFireBallKillEffect(arg_5_0, arg_5_1)
	if not arg_5_0._dirCanFireKillEffGODict then
		return
	end

	local var_5_0 = arg_5_0._target.originData:getDirection()

	for iter_5_0, iter_5_1 in pairs(arg_5_0._dirCanFireKillEffGODict) do
		gohelper.setActive(iter_5_1, arg_5_1 and var_5_0 == iter_5_0)
	end
end

function var_0_0.isShowEffect(arg_6_0, arg_6_1)
	if not arg_6_0._loader then
		return
	end

	local var_6_0 = arg_6_0._loader:getInstGO()

	if not gohelper.isNil(var_6_0) then
		gohelper.setActive(var_6_0, arg_6_1)
	end
end

function var_0_0.onDispose(arg_7_0)
	if arg_7_0._dirPointGODict then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._dirPointGODict) do
			iter_7_1 = nil
		end

		arg_7_0._dirPointGODict = nil
	end

	if arg_7_0._dirCanFireKillEffGODict then
		for iter_7_2, iter_7_3 in pairs(arg_7_0._dirCanFireKillEffGODict) do
			iter_7_3 = nil
		end

		arg_7_0._dirCanFireKillEffGODict = nil
	end
end

return var_0_0
