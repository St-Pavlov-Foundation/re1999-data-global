module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffView", package.seeall)

slot0 = class("VersionActivity1_3BuffView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_Title")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "Left/Desc/image_DescBG/#txt_Desc")
	slot0._simageWhiteCirclePath = gohelper.findChildSingleImage(slot0.viewGO, "Path/#simage_WhiteCirclePath")
	slot0._simageMainPath = gohelper.findChildSingleImage(slot0.viewGO, "Path/#simage_MainPath")
	slot0._simageBranchPath1 = gohelper.findChildSingleImage(slot0.viewGO, "Path/#simage_BranchPath1")
	slot0._simageBranchPath2 = gohelper.findChildSingleImage(slot0.viewGO, "Path/#simage_BranchPath2")
	slot0._gopath101 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path101")
	slot0._gopath102 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path102")
	slot0._gopath103 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path103")
	slot0._gopath104 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path104")
	slot0._gopath105 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path105")
	slot0._gopath201 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path201")
	slot0._gopath202 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path202")
	slot0._gopath203 = gohelper.findChild(slot0.viewGO, "Path/LightPath/#go_path203")
	slot0._simagePropIcon = gohelper.findChildSingleImage(slot0.viewGO, "Path/Prop/#simage_PropIcon")
	slot0._goBuff101 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff101")
	slot0._goBuff102 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff102")
	slot0._goBuff103 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff103")
	slot0._goBuff104 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff104")
	slot0._goBuff105 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff105")
	slot0._goBuff201 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff201")
	slot0._goBuff202 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff202")
	slot0._goBuff203 = gohelper.findChild(slot0.viewGO, "Path/#go_Buff203")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_fullbg"))
	slot0._simageWhiteCirclePath:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_whitecirclepath"))

	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Currency, Activity126Enum.buffCurrencyId)

	if not string.nilorempty(slot2) then
		slot0._simagePropIcon:LoadImage(slot2)
	end

	slot0:_addAllBuff()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onUnlockBuffReply, slot0._onUnlockBuffReply, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_open)
end

function slot0._onCurrencyChange(slot0)
	for slot4, slot5 in ipairs(slot0._buffList) do
		slot5:updateStatus()
	end
end

function slot0._onUnlockBuffReply(slot0)
	for slot4, slot5 in ipairs(slot0._buffList) do
		slot5:onUnlockBuffReply()
	end
end

function slot0._addAllBuff(slot0)
	slot0._buffList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(lua_activity126_buff.configList) do
		slot7 = slot6.id
		slot0._buffList[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0["_goBuff" .. slot7]), VersionActivity1_3BuffItem, {
			slot6,
			slot0["_gopath" .. slot7]
		})
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageWhiteCirclePath:UnLoadImage()
end

return slot0
