module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffView", package.seeall)

slot0 = class("RougeLimiterBuffView", BaseView)

function slot0.onInitView(slot0)
	slot0._gochoosebuff = gohelper.findChild(slot0.viewGO, "#go_choosebuff")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_choosebuff/#btn_close")
	slot0._gosmallbuffitem = gohelper.findChild(slot0.viewGO, "#go_choosebuff/SmallBuffView/Viewport/Content/#go_smallbuffitem")
	slot0._gobuffdec = gohelper.findChild(slot0.viewGO, "#go_buffdec")
	slot0._gobuff = gohelper.findChild(slot0.viewGO, "#go_buff")
	slot0._txtchoosebuff = gohelper.findChildText(slot0.viewGO, "#go_choosebuff/txt_choosebuff")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.OnSelectBuff, slot0._onSelectBuff, slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.CloseBuffDescTips, slot0._onCloseBuffDescTips, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenLimiterBuffView)
	slot0:init()
end

function slot0.onUpdateParam(slot0)
	slot0:init()
end

function slot0.init(slot0)
	slot0._buffType = slot0.viewParam and slot0.viewParam.buffType

	RougeLimiterBuffListModel.instance:onInit(slot0._buffType)
	slot0:initBuffEntry()
	slot0:refreshTitle()
end

function slot0.refreshTitle(slot0)
	slot0._txtchoosebuff.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougelimiterbuffoverview_txt_buff"), GameUtil.getRomanNums(slot0._buffType))
end

function slot0.initBuffEntry(slot0)
	if not slot0._buffEntry then
		slot0._gobufficon = slot0:getResInst(slot0.viewContainer:getSetting().otherRes.LimiterItem, slot0._gobuff, "#go_bufficon")
		slot0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gobufficon, RougeLimiterBuffEntry)

		slot0._buffEntry:refreshUI()
	end

	slot0._buffEntry:selectBuffEntry(slot0._buffType)
end

function slot0._onSelectBuff(slot0, slot1, slot2)
	if not slot0._buffTips then
		slot0._buffTips = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gobuffdec, RougeLimiterBuffTips)
	end

	slot0._buffTips:onUpdateMO(slot1, slot2)
	gohelper.setActive(slot0._btnclose.gameObject, not slot2)
end

function slot0._onCloseBuffDescTips(slot0)
	gohelper.setActive(slot0._btnclose.gameObject, true)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
