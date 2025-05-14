module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandChessNpc", package.seeall)

local var_0_0 = class("FairyLandChessNpc", FairyLandElementBase)

var_0_0.Setting = {
	[2] = {
		chat = "fairyland_chat01",
		chess = "fairyland_chess1"
	},
	[4] = {
		chat = "fairyland_chat02",
		chess = "fairyland_chess2"
	},
	[6] = {
		chat = "fairyland_chat03",
		chess = "fairyland_chess3"
	},
	[8] = {
		chat = "fairyland_chat04",
		chess = "fairyland_chess4"
	}
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0.rootGo = gohelper.findChild(arg_1_0._go, "root")
	arg_1_0.imgChessRoot = gohelper.findChild(arg_1_0.rootGo, "image_Chess")
	arg_1_0.animChess = arg_1_0.imgChessRoot:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.imgChess = gohelper.findChildImage(arg_1_0.rootGo, "image_Chess/#image_chess/image_chess")
	arg_1_0.goChess = arg_1_0.imgChess.gameObject
	arg_1_0.goChat = gohelper.findChild(arg_1_0.rootGo, "#image_Chat")
	arg_1_0.imageChat = gohelper.findChildImage(arg_1_0.rootGo, "#image_Chat")

	gohelper.setActive(arg_1_0.goChat, false)

	arg_1_0.chatClick = gohelper.findChildClickWithAudio(arg_1_0.rootGo, "#image_Chat")

	arg_1_0.chatClick:AddClickListener(arg_1_0.onClickChat, arg_1_0)

	local var_1_0 = var_0_0.Setting[arg_1_0._config.type]

	UISpriteSetMgr.instance:setFairyLandSprite(arg_1_0.imgChess, var_1_0.chess, true)
	UISpriteSetMgr.instance:setFairyLandSprite(arg_1_0.imageChat, var_1_0.chat, true)
end

function var_0_0.onDestroyElement(arg_2_0)
	arg_2_0.chatClick:RemoveClickListener()
end

function var_0_0.onRefresh(arg_3_0)
	local var_3_0 = arg_3_0:getCurPuzzle()
	local var_3_1 = FairyLandModel.instance:isPassPuzzle(var_3_0)
	local var_3_2 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(var_3_0)

	if var_3_1 and FairyLandModel.instance:isFinishDialog(var_3_2.successTalkId) then
		arg_3_0:setFinish()

		return
	end

	local var_3_3 = var_3_2.beforeTalkId
	local var_3_4 = arg_3_0:getElementId() - 1

	if var_3_3 == 0 or not FairyLandModel.instance:isFinishElement(var_3_4) then
		gohelper.setActive(arg_3_0.goChat, false)
	else
		local var_3_5 = FairyLandModel.instance:isFinishDialog(var_3_3)

		gohelper.setActive(arg_3_0.goChat, not var_3_5)
	end
end

function var_0_0.onClickChat(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bubble_click)

	local var_4_0 = arg_4_0:getCurPuzzle()
	local var_4_1 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(var_4_0).beforeTalkId
	local var_4_2 = {
		dialogId = var_4_1,
		dialogType = FairyLandEnum.DialogType.Bubble,
		leftElement = FairyLandModel.instance:getDialogElement(),
		rightElement = arg_4_0
	}

	FairyLandController.instance:openDialogView(var_4_2)
	gohelper.setActive(arg_4_0.goChat, false)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetTextBgVisible)
end

function var_0_0.getCurPuzzle(arg_5_0)
	local var_5_0 = string.splitToNumber(arg_5_0._config.puzzleId, "#")

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if not FairyLandModel.instance:isPassPuzzle(iter_5_1) then
			return iter_5_1
		end
	end

	return var_5_0[#var_5_0]
end

function var_0_0.getClickGO(arg_6_0)
	return arg_6_0.goChess
end

function var_0_0.playDialog(arg_7_0)
	arg_7_0.animChess:Play("jump", 0, 0)
end

return var_0_0
