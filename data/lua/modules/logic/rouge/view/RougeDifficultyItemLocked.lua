module("modules.logic.rouge.view.RougeDifficultyItemLocked", package.seeall)

slot0 = class("RougeDifficultyItemLocked", RougeDifficultyItem_Base)

function slot0.onInitView(slot0)
	slot0._goBg1 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg1")
	slot0._goBg2 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg2")
	slot0._goBg3 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg3")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "num/#txt_num1")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "num/#txt_num2")
	slot0._txtnum3 = gohelper.findChildText(slot0.viewGO, "num/#txt_num3")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_en")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	RougeDifficultyItem_Base._editableInitView(slot0)

	slot0._txtLocked = gohelper.findChildText(slot0.viewGO, "lock/txt_locked")
end

function slot0.setData(slot0, slot1)
	RougeDifficultyItem_Base.setData(slot0, slot1)

	if slot1.difficultyCO.preDifficulty and slot3 > 0 then
		slot0._txtLocked.text = formatLuaLang("rougedifficultyitemlocked_unlock_desc_fmt", RougeOutsideModel.instance:config():getDifficultyCO(slot3).title)
	else
		slot0._txtLocked.text = ""
	end
end

return slot0
