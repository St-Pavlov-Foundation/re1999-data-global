module("modules.logic.player.view.PlayerChangeBgItem", package.seeall)

slot0 = class("PlayerChangeBgItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._bgSelect = gohelper.findChild(slot1, "#go_select")
	slot0._bgCur = gohelper.findChild(slot1, "#go_cur")
	slot0._bgLock = gohelper.findChild(slot1, "#go_lock")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_click")
	slot0._simagebg = gohelper.findChildSingleImage(slot1, "#simg_bg")
	slot0._txtname = gohelper.findChildTextMesh(slot1, "#txt_name")
	slot0._goreddot = gohelper.findChild(slot1, "#go_reddot")
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0._onSelect, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, slot0.onBgSelect, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, slot0._updateStatus, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClick:RemoveClickListener()
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, slot0.onBgSelect, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, slot0._updateStatus, slot0)
end

function slot0.initMo(slot0, slot1, slot2, slot3)
	slot0._mo = slot1
	slot0._index = slot2

	slot0._simagebg:LoadImage(string.format("singlebg/playerinfo/bg/%s.png", slot1.bg))

	slot0._txtname.text = slot1.name

	slot0:onBgSelect(slot3)
	slot0:_updateStatus()

	if slot1.item > 0 then
		RedDotController.instance:addMultiRedDot(slot0._goreddot, {
			{
				id = RedDotEnum.DotNode.PlayerChangeBgItemNew,
				uid = slot1.item
			}
		})
	end
end

function slot0._updateStatus(slot0)
	slot1 = true
	slot2 = PlayerModel.instance:getPlayinfo()

	if slot0._mo.item ~= 0 then
		slot1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot0._mo.item) > 0
	end

	gohelper.setActive(slot0._bgLock, not slot1)
	gohelper.setActive(slot0._bgCur, slot2.bg == slot0._mo.item)
end

function slot0._onSelect(slot0)
	if slot0._mo.item > 0 and RedDotModel.instance:isDotShow(RedDotEnum.DotNode.PlayerChangeBgItemNew, slot1) then
		ItemRpc.instance:sendMarkReadSubType21Request(slot1)
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.ChangeBgTab, slot0._index)
end

function slot0.onBgSelect(slot0, slot1)
	gohelper.setActive(slot0._bgSelect, slot1 == slot0._index)
end

function slot0.onDestroy(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
