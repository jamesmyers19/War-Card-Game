#!/usr/bin/perl
use warnings;
use strict;

my @player_one;
my @player_two;
my @deck;

sub game_start{
    print "type Begin to start or Quit to exit!\n";
    chomp(my $response = <>);
    if($response =~ /begin/i){
        shuffle_deck();
        deal_deck();
        play_game();
    } elsif($response =~ /quit/i){
        exit();
    } else {
        game_start();
    }
}

sub end_game{
    if(scalar(@player_one) == 0){
        print "===================================\n";
        print "Player One has run out of cards... ";
        print "Player Two has Won the Game!\n";
    } elsif(scalar(@player_two) == 0){
        print "===================================\n";
        print "Player Two has run out of cards... ";
        print "Player One has Won the Game!\n";
    }
}

sub shuffle_deck{
    for (my $s = 2; $s <= 14; $s++){
        my $card = "S" . $s;
        push(@deck, $card);
    }
    for (my $h = 2; $h <= 14; $h++){
        my $card = "H" . $h;
        push(@deck, $card);
    }
    for (my $c = 2; $c <= 14; $c++){
        my $card = "C" . $c;
        push(@deck, $card);
    }
    for (my $d = 2; $d <= 14; $d++){
        my $card = "D" . $d;
        push(@deck, $card);
    }
    for (my $i = 0; $i <= 51; $i++){
        my $card = int(rand(52));
        @deck[$i, $card] = @deck[$card, $i];
    }
}

sub deal_deck{
    for (my $c = 1; $c <= 52; $c++){
        my $count = $c;
        if($count % 2 == 0){
            push(@player_two, $deck[$c]);
        } else {
            push(@player_one, $deck[$c]);
        }
    }
}

sub next_round{
    print "Enter Next to play the next round or Quit to exit\n";
    my $response = <>;
    if($response =~ /next/i){
        play_game();
    } elsif($response =~ /quit/i){
        exit();
    } else {
        next_round();
    }
}

sub tie_breaker{

    if(scalar(@player_one) == 0){
        end_game();
    } elsif(scalar(@player_two) == 0){
        end_game();
    }

    my $player_one_card = shift(@player_one);
    print "Player One has played: $player_one_card\n";
    $player_one_card =~ s/(^[A-Z])//;
    my $player_one_suit = $1;

    my $player_two_card = shift(@player_two);
    print "Player Two has played: $player_two_card\n";
    $player_two_card =~ s/(^[A-Z])//;
    my $player_two_suit = $1;

    if($player_one_card > $player_two_card){
        print "===================================\n";
        print "Player One has Won the Tie Breaker!\n";
        $player_one_card = $player_one_suit . $player_one_card;
        $player_two_card = $player_two_suit . $player_two_card;
        push(@player_one, $player_one_card);
        push(@player_one, $player_two_card);
        return "Player One";
    } elsif($player_two_card > $player_one_card){
        print "===================================\n";
        print "Player Two has Won the Tie Breaker!\n";
        $player_one_card = $player_one_suit . $player_one_card;
        $player_two_card = $player_two_suit . $player_two_card;
        push(@player_two, $player_one_card);
        push(@player_two, $player_two_card);
        return "Player Two";
    } else{
        print "There was Another Tie!\n";
        my $winner = tie_breaker();
        if($winner eq "Player One"){
            return "Player One";
        } else{
            return "Player Two";
        }
    }
}

sub play_game{

    if(scalar(@player_one) == 0){
        end_game();
    } elsif (scalar(@player_two) == 0){
        end_game();
    }

    my $player_one_card = shift @player_one;
    print "Player One has played: $player_one_card\n";
    $player_one_card =~ s/(^[A-Z])//;
    my $player_one_suit = $1;

    my $player_two_card = shift @player_two;
    print "Player Two had played: $player_two_card\n";
    $player_two_card =~ s/(^[A-Z])//;
    my $player_two_suit = $1;

    if ($player_one_card > $player_two_card){
        print "==========================\n";
        print "Player One Wins the Round!\n";
        $player_one_card = $player_one_suit . $player_one_card;
        $player_two_card = $player_two_suit . $player_two_card;
        push(@player_one, $player_one_card);
        push(@player_one, $player_two_card);
        next_round();
    } elsif ($player_two_card > $player_one_card){
        print "==========================\n";
        print "Player Two Wins the Round!\n";
        $player_one_card = $player_one_suit . $player_one_card;
        $player_two_card = $player_two_suit . $player_two_card;
        push(@player_two, $player_one_card);
        push(@player_two, $player_two_card);
        next_round();
    } else{
        print "It's a tie!\n";
        my $winner = tie_breaker();
        if($winner eq "Player One"){
            print "==========================\n";
            print "Player One Wins the Round!\n";
            $player_one_card = $player_one_suit . $player_one_card;
            $player_two_card = $player_two_suit . $player_two_card;
            push(@player_one, $player_one_card);
            push(@player_one, $player_two_card);
            next_round();
        } else{
            print "==========================\n";
            print "Player Two Wins the Round!\n";
            $player_one_card = $player_one_suit . $player_one_card;
            $player_two_card = $player_two_suit . $player_two_card;
            push(@player_two, $player_one_card);
            push(@player_two, $player_two_card);
            next_round();
        }
    }
}

print "Welcome to the game of WAR!\n";
print "*           *   *      ****\n";
print " *         *   * *     *   *\n";
print "  *   *   *   *****    ****\n";
print "   * * * *   *     *   * *\n";
print "    *   *   *       *  *  *\n";
game_start();