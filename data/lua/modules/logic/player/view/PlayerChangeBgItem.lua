module("modules.logic.player.view.PlayerChangeBgItem", package.seeall)

local var_0_0 = class("PlayerChangeBgItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._bgSelect = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._bgCur = gohelper.findChild(arg_1_1, "#go_cur")
	arg_1_0._bgLock = gohelper.findChild(arg_1_1, "#go_lock")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_click")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_1, "#simg_bg")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "#txt_name")
	arg_1_0._goreddot = gohelper.findChild(arg_1_1, "#go_reddot")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onSelect, arg_2_0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, arg_2_0.onBgSelect, arg_2_0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, arg_2_0._updateStatus, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, arg_3_0.onBgSelect, arg_3_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, arg_3_0._updateStatus, arg_3_0)
end

function var_0_0.initMo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._mo = arg_4_1
	arg_4_0._index = arg_4_2

	arg_4_0._simagebg:LoadImage(string.format("singlebg/playerinfo/bg/%s.png", arg_4_1.bg))

	arg_4_0._txtname.text = arg_4_1.name

	arg_4_0:onBgSelect(arg_4_3)
	arg_4_0:_updateStatus()

	if arg_4_1.item > 0 then
		RedDotController.instance:addMultiRedDot(arg_4_0._goreddot, {
			{
				id = RedDotEnum.DotNode.PlayerChangeBgItemNew,
				uid = arg_4_1.item
			}
		})
	end
end

function var_0_0._updateStatus(arg_5_0)
	local var_5_0 = true
	local var_5_1 = PlayerModel.instance:getPlayinfo()

	if arg_5_0._mo.item ~= 0 then
		var_5_0 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, arg_5_0._mo.item) > 0
	end

	gohelper.setActive(arg_5_0._bgLock, not var_5_0)
	gohelper.setActive(arg_5_0._bgCur, var_5_1.bg == arg_5_0._mo.item)
end

function var_0_0._onSelect(arg_6_0)
	local var_6_0 = arg_6_0._mo.item

	if var_6_0 > 0 and RedDotModel.instance:isDotShow(RedDotEnum.DotNode.PlayerChangeBgItemNew, var_6_0) then
		ItemRpc.instance:sendMarkReadSubType21Request(var_6_0)
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.ChangeBgTab, arg_6_0._index)
end

function var_0_0.onBgSelect(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._bgSelect, arg_7_1 == arg_7_0._index)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._simagebg:UnLoadImage()
end

return var_0_0
