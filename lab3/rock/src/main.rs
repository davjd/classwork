use std::io::{self, Write};
use rand::Rng;
use num_derive::FromPrimitive;    
use num_traits::FromPrimitive;

#[derive(Debug, Copy, Clone, FromPrimitive, PartialEq)]
enum ItemSelection {
    Rock,
    Paper,
    Scissor,
    Invalid,
}

fn get_selection_from_input(input: &str) -> ItemSelection {
  use ItemSelection::*;
  match input {
    "rock" | "r" | "0" => Rock,
    "paper" | "p" | "1" => Paper,
    "scissor" | "s" | "2 "=> Scissor,
    _ => Invalid,
  }
}

fn main() {
    use ItemSelection::*;
    const TARGET_WIN_NUM: u32 = 3;
    let mut player_score = 0;
    let mut cpu_score = 0;
    let mut rng = rand::thread_rng();
    while player_score < TARGET_WIN_NUM && cpu_score < TARGET_WIN_NUM {
        print!("\nType your selection (rock, paper, scissor): ");
        io::stdout().flush();
        let mut player_input = String::new();
        io::stdin().read_line(&mut player_input)
            .expect("Couldn't read selection.");

        let player_selection : ItemSelection = get_selection_from_input(player_input.trim());
        let cpu_selection:ItemSelection = FromPrimitive::from_i32(rng.gen_range(0, 3)).unwrap();
        println!("cpu: {:?}", cpu_selection);

        match (player_selection, cpu_selection) {
            (Rock, Scissor) => {
                println!("{:?} beats {:?}, you win!", player_selection, cpu_selection);
                player_score += 1;
            },
            (Scissor, Rock) => {
                println!("{:?} beats {:?}, you lose!", cpu_selection, player_selection);
                cpu_score += 1;
            },
            (Invalid, _) => {
                println!("Invalid selection! Try again (`rock`, `paper`, `scissor`).");
            },
            _ if player_selection == cpu_selection => {
                println!("{:?} ties with {:?}! Continue..", player_selection, cpu_selection);
            },
            _ if player_selection as i32 > cpu_selection as i32 => {
                println!("{:?} beats {:?}, you win!", player_selection, cpu_selection);
                player_score += 1;
            },
            _ => {
                println!("{:?} beats {:?}, you lose!", cpu_selection, player_selection);
                cpu_score += 1;
            },
        }
    }
    if cpu_score == TARGET_WIN_NUM {
        println!("You lost!");
    } else if player_score == TARGET_WIN_NUM {
        println!("You won, congrats!");
    }
}