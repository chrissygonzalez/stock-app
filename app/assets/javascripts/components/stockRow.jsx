class StockRow extends React.Component {
    render() {
      return (
        <tr>
            <td class={this.props.style}>{this.props.symbol}</td> 
            <td class={this.props.style}>{this.props.change}</td>
            <td>{this.props.quantity}</td>
            <td class={this.props.style}>${this.props.value}</td>
        </tr>
        )
    }
  }