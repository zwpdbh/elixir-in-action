defmodule Ch04Test do
  use ExUnit.Case, async: true
  setup do
    {:ok,
     school_ops: [
        %GPS.Op{
          action: "drive son to school",
          preconds: ["son at home", "car works"],
          add_lst: ["son at school"],
          del_lst: ["son at home"]
        },
        %GPS.Op{
          action: "show install battery",
          preconds: ["car needs battery", "shop knows problem", "shop has money"],
          add_lst: ["car works"]
        },
        %GPS.Op{
          action: "tell shop problem",
          preconds: ["in communication with shop"],
          add_lst: ["shop knows problem"]
        },
        %GPS.Op{
          action: "telephone shop",
          preconds: ["know phone number"],
          add_lst: ["in communication with shop"]
        },
        %GPS.Op{
          action: "look up number",
          preconds: ["have phone book"],
          add_lst: ["know phone number"]
        },
        %GPS.Op{
          action: "give shop money",
          preconds: ["have money"],
          add_lst: ["shop has money"],
          del_lst: ["have money"]
        }
      ]
    }
  end
  
  describe "part one" do
    test "drive to school", %{school_ops: school_ops} do
      current_state = [
        "son at home",
        "car needs battery",
        "have money",
        "have phone book"
      ]
      goals = [
        "son at school"
      ]

      assert "solved" = GPS.gps(current_state, goals, school_ops)
    end

    test "drive to school 02", %{school_ops: school_ops} do
      current_state = [
        "son at home",
        "car needs battery",
        "have money"
      ]
      goals = [
        "son at school"
      ]

      assert "not solved" = GPS.gps(current_state, goals, school_ops)
    end

    test "drive to school 03", %{school_ops: school_ops} do
      current_state = [
        "son at school"
      ]
      goals = [
        "son at school"
      ]

      assert "solved" = GPS.gps(current_state, goals, school_ops)
    end
    
  end
end
