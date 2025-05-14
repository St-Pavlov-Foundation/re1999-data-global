module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapNodeItem", package.seeall)

local var_0_0 = class("Activity1_3ChessMapNodeItem", LuaCompBase)

var_0_0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_mapviewstageitem.prefab"

local var_0_1 = {
	open = 2,
	passIncompletly = 3,
	lock = 1,
	pass = 4
}
local var_0_2 = "#E3C479"
local var_0_3 = "#FFFFFF"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goRoot = gohelper.findChild(arg_1_1, "Root")
	arg_1_0._imagePoint = gohelper.findChildImage(arg_1_1, "Root/#image_Point")
	arg_1_0._imageStageFinishedBG = gohelper.findChildImage(arg_1_1, "Root/unlock/#image_StageFinishedBG")
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_1, "Root/unlock/Info/#txt_StageName")
	arg_1_0._txtStageNum = gohelper.findChildText(arg_1_1, "Root/unlock/Info/#txt_StageName/#txt_StageNum")
	arg_1_0._imageNoStar = gohelper.findChildImage(arg_1_1, "Root/unlock/Info/#txt_StageName/#image_NoStar")
	arg_1_0._imageHasStar = gohelper.findChildImage(arg_1_1, "Root/unlock/Info/#txt_StageName/#image_Star")
	arg_1_0._btnClick = gohelper.findChildClick(arg_1_1, "Root/unlock/#btn_Click")
	arg_1_0._btnReview = gohelper.findChildButtonWithAudio(arg_1_1, "Root/unlock/Info/#txt_StageName/#btn_Review")
	arg_1_0._goUnLock = gohelper.findChild(arg_1_1, "Root/unlock")
	arg_1_0._goChess = gohelper.findChild(arg_1_1, "Root/unlock/image_chess")

	local var_1_0 = gohelper.findChild(arg_1_1, "Root/unlock/image_chess/ani")
	local var_1_1 = typeof(UnityEngine.Animator)

	arg_1_0._nodeItemAnimator = arg_1_1:GetComponent(var_1_1)
	arg_1_0._chessAnimator = var_1_0:GetComponent(var_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0._btnReview:AddClickListener(arg_2_0._btnReviewOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	if arg_3_0._btnClick then
		arg_3_0._btnClick:RemoveClickListener()
		arg_3_0._btnReview:RemoveClickListener()
	end
end

function var_0_0._btnClickOnClick(arg_4_0)
	if not arg_4_0._config then
		return
	end

	if not arg_4_0._clickCallback then
		return
	end

	arg_4_0._clickCallback(arg_4_0._clickCbObj, arg_4_0._config.id)
end

function var_0_0._btnReviewOnClick(arg_5_0)
	if arg_5_0._config then
		Activity1_3ChessController.instance:openStoryView(arg_5_0._config.id)
	end
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	return
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	return
end

function var_0_0.setCfg(arg_8_0, arg_8_1)
	arg_8_0._config = arg_8_1
	arg_8_0._isLock = true
end

function var_0_0.setClickCallback(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._clickCallback = arg_9_1
	arg_9_0._clickCbObj = arg_9_2
end

function var_0_0._checkNodeItemState(arg_10_0)
	local var_10_0 = Activity122Model.instance:getEpisodeData(arg_10_0._config.id)

	if var_10_0 then
		if var_10_0.star == 2 then
			return var_0_1.pass
		elseif var_10_0.star == 1 then
			return var_0_1.passIncompletly
		else
			return var_0_1.open
		end
	end

	if arg_10_0._config.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(arg_10_0._config.preEpisode) and Activity1_3ChessController.isOpenDay(arg_10_0._config.id) then
		return var_0_1.open
	else
		return var_0_1.lock
	end
end

function var_0_0.refreshUI(arg_11_0)
	if not arg_11_0._config then
		gohelper.setActive(arg_11_0._goRoot, false)

		return
	end

	gohelper.setActive(arg_11_0._goRoot, true)

	local var_11_0 = arg_11_0:_checkNodeItemState()

	arg_11_0:_refreshNodeStateView(var_11_0)

	arg_11_0._txtStageName.text = arg_11_0._config.name
	arg_11_0._txtStageNum.text = arg_11_0._config.orderId

	arg_11_0:_refreshChess()
end

function var_0_0._refreshNodeStateView(arg_12_0, arg_12_1)
	if arg_12_0._nodeStateViewAction == nil then
		arg_12_0._nodeStateViewAction = {
			[var_0_1.lock] = arg_12_0._lockUI,
			[var_0_1.open] = arg_12_0._unLockUI,
			[var_0_1.passIncompletly] = arg_12_0._refreshPassIncompletlyView,
			[var_0_1.pass] = arg_12_0._refreshPassView
		}
	end

	arg_12_0._nodeStateViewAction[arg_12_1](arg_12_0)
	UISpriteSetMgr.instance:setActivity1_3ChessSprite(arg_12_0._imagePoint, arg_12_0:_getNodePointSprite(arg_12_1))

	if arg_12_1 == var_0_1.lock then
		return
	end

	local var_12_0 = Activity122Model.instance:getPlayerCacheData()
	local var_12_1 = arg_12_1 == var_0_1.open and not var_12_0["isEpisodeUnlock_" .. arg_12_0._config.id]

	if (arg_12_1 == var_0_1.pass or arg_12_1 == var_0_1.passIncompletly) and not var_12_0["isEpisodePass_" .. arg_12_0._config.id] then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.SetNodePathEffectToPassNode)
		arg_12_0:delayPlayNodePassAni(0.8)
	end

	if var_12_1 then
		gohelper.setActive(arg_12_0._goRoot, false)
		arg_12_0:delayPlayNodeUnlockAni(1.5)
	end
end

function var_0_0._getNodePointSprite(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._nodeState2SpriteMap == nil then
		arg_13_0._nodeState2SpriteMap = {
			[var_0_1.lock] = JiaLaBoNaEnum.StatgePiontSpriteName.UnFinished,
			[var_0_1.open] = Activity1_3ChessEnum.SpriteName.NodeUnFinished,
			[var_0_1.passIncompletly] = Activity1_3ChessEnum.SpriteName.NodeFinished,
			[var_0_1.pass] = Activity1_3ChessEnum.SpriteName.NodeFinished
		}
	end

	local var_13_0 = arg_13_0._nodeState2SpriteMap[arg_13_1]
	local var_13_1 = Activity122Model.instance:getCurEpisodeId()
	local var_13_2 = arg_13_0._config.id == var_13_1 or arg_13_2

	if arg_13_2 ~= nil then
		var_13_2 = arg_13_2
	end

	var_13_0 = var_13_2 and Activity1_3ChessEnum.SpriteName.NodeCurrent or var_13_0

	return var_13_0
end

function var_0_0._refreshPassView(arg_14_0)
	gohelper.setActive(arg_14_0._goUnLock, true)
	gohelper.setActive(arg_14_0._btnReview.gameObject, true)
	gohelper.setActive(arg_14_0._imageStageFinishedBG, true)
	SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._imagePoint, var_0_2)
	arg_14_0:_refreshStarState(true)
end

function var_0_0._refreshPassIncompletlyView(arg_15_0)
	gohelper.setActive(arg_15_0._goUnLock, true)
	gohelper.setActive(arg_15_0._imageStageFinishedBG, true)
	gohelper.setActive(arg_15_0._btnReview.gameObject, true)
	SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._imagePoint, var_0_2)
	arg_15_0:_refreshStarState(false)
end

function var_0_0._lockUI(arg_16_0)
	gohelper.setActive(arg_16_0._goUnLock, false)
	gohelper.setActive(arg_16_0._btnReview.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._imagePoint, var_0_3)
end

function var_0_0._unLockUI(arg_17_0)
	gohelper.setActive(arg_17_0._goUnLock, true)
	gohelper.setActive(arg_17_0._imageStageFinishedBG, false)
	gohelper.setActive(arg_17_0._btnReview.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._imagePoint, var_0_2)
	arg_17_0:_refreshStarState(false)
end

function var_0_0._refreshStarState(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._imageNoStar.gameObject, not arg_18_1)
	gohelper.setActive(arg_18_0._imageHasStar.gameObject, arg_18_1)
end

function var_0_0._refreshChess(arg_19_0)
	local var_19_0 = Activity122Model.instance:getCurEpisodeId()

	if var_19_0 == 0 then
		gohelper.setActive(arg_19_0._goChess, arg_19_0._config.id == 1)
	else
		gohelper.setActive(arg_19_0._goChess, arg_19_0._config.id == var_19_0)
	end
end

function var_0_0.delayPlayNodePassAni(arg_20_0, arg_20_1)
	arg_20_0._nodeStateViewAction[var_0_1.open](arg_20_0)

	arg_20_1 = arg_20_1 or 0.5

	TaskDispatcher.runDelay(arg_20_0.playNodePassAni, arg_20_0, arg_20_1)
end

function var_0_0.delayPlayNodeUnlockAni(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._goRoot, false)

	arg_21_1 = arg_21_1 or 0.5

	TaskDispatcher.runDelay(arg_21_0.playNodeUnlockAni, arg_21_0, arg_21_1)
end

function var_0_0.playNodePassAni(arg_22_0)
	Activity122Model.instance:getPlayerCacheData()["isEpisodePass_" .. arg_22_0._config.id] = true

	Activity122Model.instance:saveCacheData()
	gohelper.setActive(arg_22_0._imageStageFinishedBG.gameObject, true)

	local var_22_0 = arg_22_0:_checkNodeItemState()

	arg_22_0:_refreshStarState(var_22_0 == var_0_1.pass)
	arg_22_0._nodeItemAnimator:Play("finish")
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ShowPassEpisodeEffect)
	TaskDispatcher.runDelay(arg_22_0.refreshUI, arg_22_0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)
end

function var_0_0.playNodeUnlockAni(arg_23_0)
	Activity122Model.instance:getPlayerCacheData()["isEpisodeUnlock_" .. arg_23_0._config.id] = true

	Activity122Model.instance:saveCacheData()
	gohelper.setActive(arg_23_0._goRoot, true)
	arg_23_0._nodeItemAnimator:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NewEpisodeUnlock)
end

function var_0_0.playAppearAni(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._goChess, true)

	local var_24_0 = Activity122Model.instance:getCurEpisodeId()
	local var_24_1 = arg_24_1 < arg_24_0._config.id and "open_right" or "open_left"

	arg_24_0._chessAnimator:Play(var_24_1)

	local var_24_2 = arg_24_0:_checkNodeItemState()

	UISpriteSetMgr.instance:setActivity1_3ChessSprite(arg_24_0._imagePoint, arg_24_0:_getNodePointSprite(var_24_2, true))
end

function var_0_0.playDisAppearAni(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0._goChess, true)

	local var_25_0 = Activity122Model.instance:getCurEpisodeId()
	local var_25_1 = arg_25_1 > arg_25_0._config.id and "close_right" or "close_left"

	arg_25_0._chessAnimator:Play(var_25_1)

	local var_25_2 = arg_25_0:_checkNodeItemState()

	UISpriteSetMgr.instance:setActivity1_3ChessSprite(arg_25_0._imagePoint, arg_25_0:_getNodePointSprite(var_25_2, false))
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._clickCallback = nil
	arg_26_0._clickCbObj = nil

	arg_26_0:removeEventListeners()
	TaskDispatcher.cancelTask(arg_26_0.playNodePassAni, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.playNodeUnlockAni, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.refreshUI, arg_26_0)
end

return var_0_0
