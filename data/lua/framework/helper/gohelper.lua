module("framework.helper.gohelper", package.seeall)

local var_0_0 = {
	Type_Image = typeof(UnityEngine.UI.Image),
	Type_Text = typeof(UnityEngine.UI.Text),
	Type_TextMesh = typeof(TMPro.TextMeshProUGUI),
	Type_RawImage = typeof(UnityEngine.UI.RawImage),
	Type_Toggle = typeof(UnityEngine.UI.Toggle),
	Type_ToggleGroup = typeof(UnityEngine.UI.ToggleGroup),
	Type_ScrollRect = typeof(UnityEngine.UI.ScrollRect),
	Type_Graphic = typeof(UnityEngine.UI.Graphic),
	Type_CanvasRenderer = typeof(UnityEngine.CanvasRenderer),
	Type_GridLayoutGroup = typeof(UnityEngine.UI.GridLayoutGroup),
	Type_HorizontalLayoutGroup = typeof(UnityEngine.UI.HorizontalLayoutGroup),
	Type_VerticalLayoutGroup = typeof(UnityEngine.UI.VerticalLayoutGroup)
}
local var_0_1 = UnityEngine.GameObject
local var_0_2 = SLFramework.GameObjectHelper
local var_0_3 = SLFramework.UGUI.ButtonWrap
local var_0_4 = SLFramework.UGUI.InputFieldWrap
local var_0_5 = SLFramework.UGUI.ScrollRectWrap
local var_0_6 = SLFramework.UGUI.SliderWrap
local var_0_7 = SLFramework.UGUI.ToggleWrap
local var_0_8 = SLFramework.UGUI.SingleImage
local var_0_9 = SLFramework.UGUI.UIClickListener

function var_0_0.isNil(arg_1_0)
	return arg_1_0 == nil or arg_1_0:Equals(nil)
end

function var_0_0.destroy(arg_2_0)
	if not var_0_0.isNil(arg_2_0) then
		var_0_1.Destroy(arg_2_0)
	end
end

function var_0_0.addChild(arg_3_0, arg_3_1)
	var_0_2.AddChild(arg_3_0, arg_3_1)
end

function var_0_0.destroyAllChildren(arg_4_0)
	var_0_2.DestroyAllChildren(arg_4_0)
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	return var_0_2.SetActive(arg_5_0, arg_5_1 and true or false)
end

function var_0_0.setAsFirstSibling(arg_6_0)
	var_0_2.SetAsFirstSibling(arg_6_0)
end

function var_0_0.setAsLastSibling(arg_7_0)
	var_0_2.SetAsLastSibling(arg_7_0)
end

function var_0_0.setSibling(arg_8_0, arg_8_1)
	var_0_2.SetSibling(arg_8_0, arg_8_1)
end

function var_0_0.getSibling(arg_9_0)
	return var_0_2.GetSibling(arg_9_0)
end

function var_0_0.setSiblingBefore(arg_10_0, arg_10_1)
	return var_0_2.SetSiblingBefore(arg_10_0, arg_10_1)
end

function var_0_0.setSiblingAfter(arg_11_0, arg_11_1)
	return var_0_2.SetSiblingAfter(arg_11_0, arg_11_1)
end

function var_0_0.setLayer(arg_12_0, arg_12_1, arg_12_2)
	var_0_2.SetLayer(arg_12_0, arg_12_1, arg_12_2)
end

function var_0_0.setTag(arg_13_0, arg_13_1, arg_13_2)
	var_0_2.SetTag(arg_13_0, arg_13_1, arg_13_2)
end

function var_0_0.find(arg_14_0)
	return var_0_1.Find(arg_14_0)
end

function var_0_0.findChild(arg_15_0, arg_15_1)
	return var_0_2.FindChild(arg_15_0, arg_15_1)
end

function var_0_0.findChildComponent(arg_16_0, arg_16_1, arg_16_2)
	return var_0_2.FindChildComponent(arg_16_0, arg_16_1, arg_16_2)
end

function var_0_0.onceAddComponent(arg_17_0, arg_17_1)
	return var_0_2.OnceAddComponent(arg_17_0, arg_17_1)
end

function var_0_0.findChildText(arg_18_0, arg_18_1)
	return var_0_0.findChildComponent(arg_18_0, arg_18_1, var_0_0.Type_TextMesh) or var_0_0.findChildComponent(arg_18_0, arg_18_1, var_0_0.Type_Text)
end

function var_0_0.findChildTextMesh(arg_19_0, arg_19_1)
	return var_0_0.findChildComponent(arg_19_0, arg_19_1, var_0_0.Type_TextMesh)
end

function var_0_0.findChildImage(arg_20_0, arg_20_1)
	return var_0_0.findChildComponent(arg_20_0, arg_20_1, var_0_0.Type_Image)
end

function var_0_0.create2d(arg_21_0, arg_21_1)
	return var_0_2.Create(arg_21_0, arg_21_1, true)
end

function var_0_0.create3d(arg_22_0, arg_22_1)
	return var_0_2.Create(arg_22_0, arg_22_1, false)
end

function var_0_0.clone(arg_23_0, arg_23_1, arg_23_2)
	return var_0_2.Clone(arg_23_0, arg_23_1, arg_23_2)
end

function var_0_0.cloneInPlace(arg_24_0, arg_24_1)
	return var_0_2.CloneInPlace(arg_24_0, arg_24_1)
end

function var_0_0.findChildButtonWithAudio(arg_25_0, arg_25_1)
	return var_0_3.GetWithPath(arg_25_0, arg_25_1)
end

function var_0_0.findChildButton(arg_26_0, arg_26_1)
	return var_0_3.GetWithPath(arg_26_0, arg_26_1)
end

function var_0_0.findChildInputField(arg_27_0, arg_27_1)
	return var_0_4.GetWithPath(arg_27_0, arg_27_1)
end

function var_0_0.findChildScrollRect(arg_28_0, arg_28_1)
	return var_0_5.GetWithPath(arg_28_0, arg_28_1)
end

function var_0_0.findChildSlider(arg_29_0, arg_29_1)
	return var_0_6.GetWithPath(arg_29_0, arg_29_1)
end

function var_0_0.findChildToggle(arg_30_0, arg_30_1)
	return var_0_7.GetWithPath(arg_30_0, arg_30_1)
end

function var_0_0.findChildSingleImage(arg_31_0, arg_31_1)
	return var_0_8.GetWithPath(arg_31_0, arg_31_1)
end

function var_0_0.getSingleImage(arg_32_0)
	return var_0_8.Get(arg_32_0)
end

function var_0_0.findChildClick(arg_33_0, arg_33_1)
	return var_0_9.GetWithPath(arg_33_0, arg_33_1)
end

function var_0_0.getClick(arg_34_0)
	return var_0_9.Get(arg_34_0)
end

return var_0_0
