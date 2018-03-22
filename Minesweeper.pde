

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 25;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int row = 0; row < NUM_ROWS; row++)
    {
        for (int col = 0; col < NUM_COLS; col++)
            //new MSButton(row,col);
        {
          buttons[row][col] = new MSButton(row,col); 
        }

    }
    
    setBombs();
    
}
public void setBombs()
{
    while(bombs.size() < NUM_BOMBS)
    {
        int r = (int)(Math.random()*NUM_COLS);
        int c = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[r][c]))
        {
            //add[r][c] to bombs
            bombs.add(buttons[r][c]);
            System.out.println(r + ", " + c);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
     for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; r < NUM_COLS; r++)
        {
            if(!buttons[r][c].isMarked() && !buttons[r][c].isClicked())   
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    String message = "You Lose";
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; r < NUM_COLS; r++)
            if(bombs.contains(buttons[r][c]))
            {
                //buttons[r][c].setLabel("B");
            }
    }
    for(int i = 0; i < message.length(); i++)
    {
        buttons[10][i+6].setLabel(message.substring(i,i+1));
    }
}
public void displayWinningMessage()
{
    String message = "You Win";
     for(int i = 0; i < message.length(); i++)
    {
        buttons[10][i+6].setLabel(message.substring(i,i+1));
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager

    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
            marked = !marked;
        // if(marked == false)
        //     clicked = false;

        else if (bombs.contains(this))
            displayLosingMessage();

        else if (countBombs(r,c) > 0)
            label = " " + countBombs(r,c);

        else {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();

             if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();

             if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();

             if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();

             if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                buttons[r-1][c-1].mousePressed();

             if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                buttons[r+1][c+1].mousePressed();

             if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                buttons[r-1][c+1].mousePressed();

             if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                buttons[r+1][c-1].mousePressed();
        }
    

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
        return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
         if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++; 

         if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;

         if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;

         if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;

         if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++; 

         if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;

         if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;

         if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;


        return numBombs;
    }
}



