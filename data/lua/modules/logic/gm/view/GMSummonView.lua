module("modules.logic.gm.view.GMSummonView", package.seeall)

local var_0_0 = class("GMSummonView", BaseView)

var_0_0._Type2Name = {
	AllSummon = 4,
	DiffRarity = 1,
	DiffRarityCount = 2,
	UpSummon = 3
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "node/infoScroll/Viewport/#go_Content")
	arg_1_0._click = gohelper.findChildButton(arg_1_0.viewGO, "node/close")
	arg_1_0._itemList = {}
	arg_1_0._paragraphItems = arg_1_0:getUserDataTb_()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._poolId, arg_4_0._totalCount, arg_4_0._star6TotalCount, arg_4_0._star5TotalCount = GMSummonModel.instance:getAllInfo()

	arg_4_0:_initView()
end

function var_0_0._initView(arg_5_0)
	arg_5_0:cleanParagraphs()

	for iter_5_0 = 1, 3 do
		local var_5_0 = arg_5_0._itemList[iter_5_0] or arg_5_0:getUserDataTb_()

		var_5_0.go = gohelper.findChild(arg_5_0.viewGO, "node/infoScroll/Viewport/#go_Content/#go_infoItem" .. iter_5_0)
		var_5_0.txtdesctitle = gohelper.findChildText(var_5_0.go, "desctitle/#txt_desctitle")

		arg_5_0:_createParagraphUI(iter_5_0, var_5_0)
	end
end

function var_0_0._createParagraphUI(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == var_0_0._Type2Name.DiffRarity then
		local var_6_0 = GMSummonModel.instance:getDiffRaritySummonHeroInfo()

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			arg_6_0:createParaItem(arg_6_2.go).text = iter_6_1.star .. "星：" .. iter_6_1.per * 100 .. "% (" .. iter_6_1.num .. "/" .. arg_6_0._totalCount .. ")"
		end
	elseif arg_6_1 == var_0_0._Type2Name.DiffRarityCount then
		local var_6_1 = GMSummonModel.instance:getDiffRaritySummonShowInfo()

		for iter_6_2, iter_6_3 in ipairs(var_6_1) do
			arg_6_0:createParaItem(arg_6_2.go).text = iter_6_3.star .. "星：" .. iter_6_3.num
		end
	elseif arg_6_1 == var_0_0._Type2Name.UpSummon then
		local var_6_2, var_6_3 = GMSummonModel.instance:getUpHeroInfo()

		arg_6_0:createParaItem(arg_6_2.go).text = "UP角色"

		arg_6_0:createUPParaItem(arg_6_2.go, var_6_2)

		arg_6_0:createParaItem(arg_6_2.go).text = "\n非UP角色"

		arg_6_0:createUPParaItem(arg_6_2.go, var_6_3)
	elseif arg_6_1 == var_0_0._Type2Name.AllSummon then
		local var_6_4 = GMSummonModel.instance:getAllSummonHeroInfo()

		for iter_6_4, iter_6_5 in ipairs(var_6_4) do
			local var_6_5 = arg_6_0:createParaItem(arg_6_2.go)
			local var_6_6 = GMSummonModel.instance:getTargetName(iter_6_5.id)

			var_6_5.text = "(" .. iter_6_5.star .. "星)" .. var_6_6 .. "：" .. iter_6_5.per * 100 .. "% (" .. iter_6_5.num .. "/" .. arg_6_0._totalCount .. ")"
		end
	end
end

function var_0_0.createUPParaItem(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		local var_7_0 = arg_7_0:createParaItem(arg_7_1)
		local var_7_1 = GMSummonModel.instance:getTargetName(iter_7_1.id)

		if iter_7_1.star == 6 then
			var_7_0.text = "(" .. iter_7_1.star .. "星)" .. var_7_1 .. "：" .. iter_7_1.per * 100 .. "% (" .. iter_7_1.num .. "/" .. arg_7_0._star6TotalCount .. ")"
		elseif iter_7_1.star == 5 then
			var_7_0.text = "(" .. iter_7_1.star .. "星)" .. var_7_1 .. "：" .. iter_7_1.per * 100 .. "% (" .. iter_7_1.num .. "/" .. arg_7_0._star5TotalCount .. ")"
		end
	end
end

function var_0_0.createParaItem(arg_8_0, arg_8_1)
	local var_8_0
	local var_8_1 = gohelper.findChild(arg_8_1, "#txt_descContent")
	local var_8_2 = gohelper.cloneInPlace(var_8_1, "para_1")
	local var_8_3 = var_8_2:GetComponent(gohelper.Type_TextMesh)

	gohelper.setActive(var_8_2, true)
	table.insert(arg_8_0._paragraphItems, var_8_2)

	return var_8_3
end

function var_0_0.cleanParagraphs(arg_9_0)
	for iter_9_0 = #arg_9_0._paragraphItems, 1, -1 do
		gohelper.destroy(arg_9_0._paragraphItems[iter_9_0])

		arg_9_0._paragraphItems[iter_9_0] = nil
	end
end

return var_0_0
