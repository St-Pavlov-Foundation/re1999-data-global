module("modules.logic.gm.view.GMLangTxtLangItem", package.seeall)

slot0 = class("GMLangTxtLangItem", UserDataDispose)
slot0.pattenList = {
	"%[([^%]]*)%]",
	"【([^】]*)】",
	"%d"
}
slot0.replacement = "<color=yellow>%0</color>"

function slot0.init(slot0, slot1, slot2)
	slot0._txtlang = gohelper.findChildText(slot1, "lang")
	slot0._txt = gohelper.findChildText(slot1, "txt")
	slot0._btnCopy = gohelper.findChildButtonWithAudio(slot1, "btnCopy")

	slot0._btnCopy:AddClickListener(slot0._onClickCopy, slot0)

	slot0._txtlang.text = slot2
	slot0.lang = slot2

	gohelper.setActive(slot1, true)
end

function slot0.updateStr(slot0, slot1)
	if not GMLangController.instance:getInUseDic()[slot1] or not slot2[slot1][slot0.lang] then
		slot0._txt.text = ""
	else
		slot0._langTxt = slot2[slot1][slot0.lang]

		for slot7, slot8 in ipairs(uv0.pattenList) do
			slot3 = string.gsub(slot0._langTxt, slot8, uv0.replacement)
		end

		slot0._txt.text = slot3
	end
end

function slot0._onClickCopy(slot0)
	ZProj.UGUIHelper.CopyText(slot0._langTxt)
end

function slot0.onClose(slot0)
	slot0._btnCopy:RemoveClickListener()
end

return slot0
